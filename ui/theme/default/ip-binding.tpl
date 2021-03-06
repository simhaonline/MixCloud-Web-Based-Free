{include file="sections/header.tpl"}

			<script>				
				function enable() {
					document.getElementById("hs_users").setAttribute("action", "{$_url}mikrotik/enable-selected-binding");
					document.forms['hs_users'].submit();
				}
				function disable() {
					document.getElementById("hs_users").setAttribute("action", "{$_url}mikrotik/disable-selected-binding");
					document.forms['hs_users'].submit();
				}
				function remove() {
					if(confirm('{$_L["API_Remove_Alert"]}')){
						document.getElementById("hs_users").setAttribute("action", "{$_url}mikrotik/remove-selected-binding");
						document.forms['hs_users'].submit();
					}
				}					
			</script>

			<div class="content-wrapper">
				<section class="content">
					<div class="row">
						{if isset($notify)}
							{$notify}
						{/if}
						<div class="col-sm-12">
							<div class="panel">
								<div class="panel-heading">IP Binding</div>
								<div class="panel-body">
									<div class="group">
										<div style="margin-top:4px;" class="dropdown "><a style="width:170px" href="#" class="dropdown-toggle btn btn-success waves-effect" data-toggle="dropdown" aria-expanded="false"><i class="ion ion-navicon-round"></i> {$_L['Option_Menu']}<span class="caret"></a></span>
											<ul style="margin-left:2px;width:auto;min-width:168px" class="dropdown-menu">	
												<li style="margin-left:8px;color:red" class="dropdown-title">Add/Create</li>
												<li><a href="#add-binding" data-toggle="modal" data-target="#add-binding" title="ADD NEW IP BINDING"><i class="ion ion-ios-sunny"></i> New Binding</a></li>
												<li style="margin-left:8px;color:red" class="dropdown-title">Action</li>
												<li><a onclick="enable();"  href="#enable" title="ENABLE SELECTED"><i class="ion ion-ios-sunny"></i> Enable Selected</a></li>	
												<li><a onclick="disable();"  href="#disable" title="DISABLE SELECTED"><i class="ion ion-ios-sunny"></i> Disable Selected</a></li>
												<li><a onclick="remove();"  href="#remove" title="REMOVE SELECTED"> <i class="ion ion-ios-sunny"></i> Remove Selected</a></li>												
											</ul>
										</div>
									</div>									
									<hr>
									<div class="adv-table table-responsive">
										<form id="binding" method="post" role="form">
											<table  class="display table table-bordered table-bordered" id="dynamic-table">
												<thead>
													<tr>
														<th class="text-center"><input onclick="toggle(this);" type="checkbox" id="checkAll"></th>
														<th>IP Address</th>
														<th>MAC Address</th>
														<th>To address</th>
														<th>Type</th>
														<th style="max-width:150px">Comment</th>
														<th>Status</th>
														<th>Manage</th>
													</tr>
												</thead>
												<tbody>
												{foreach $ip_binding as $binding}
													<tr>
														<td align="center">													
															<input type="checkbox" name="checked[]" value="{$binding['.id']}">
														</td>
														<td>{$binding['address']}</td>
														<td>{$binding['mac-address']}</td>
														<td>{$binding['to-address']}</td>
													{if !$binding['type']}	
														<td>regular</td>
													{else}
														<td>{$binding['type']}</td>
													{/if}	
														<td>{$binding['comment']}</td>
														
													{if {$binding['disabled']} eq 'true' }
														<td>
														<a href="{$_url}mikrotik/enable-binding&id={$binding['.id']}" id="{$binding['.id']}" title="ENABLE THIS BINDING"><span style="width:65px;" class="btn btn-danger btn-sm cdelete">Disable</span></a>
														</td>
													{else}
														<td>
														<a href="{$_url}mikrotik/disable-binding&id={$binding['.id']}" id="{$binding['.id']}" title="DISABLE THIS BINDING"><span style="width:65px;" class="btn btn-success btn-sm cdelete">Enable</span></a>
														</td>
													{/if}													
														<td>													
															<a href="{$_url}mikrotik/edit-binding&id={$binding['.id']}" id="{$binding['.id']}" title="EDIT THIS BINDING" style="color:#fff;font-size:17px;width:30px;height:30px;" class="btn btn-success btn-sm cdelete fa fa-pencil-square-o" aria-hidden="true"></a>
															<a href="{$_url}mikrotik/remove-binding&id={$binding['.id']}" id="{$binding['.id']}" title="REMOVE THIS BINDING" onClick="return confirm('{$_L['API_Remove_Alert']}')" style="color:#fff;font-size:17px;width:30px;height:30px;" class="btn btn-warning btn-sm cdelete fa fa-trash" aria-hidden="true"></a>
														</td>
													</tr>
												{/foreach}
												</tbody>
											</table>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>						
	
			<!--modal add binding -->
			<div class="modal fade" id="add-binding" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
				<div  class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							<h4 class="modal-title" id="myModalLabel">Add IP Binding</h4>
						</div>
						<div class="modal-body">
							<form id="modal-form" class="form-horizontal" method="post" role="form" action="{$_url}mikrotik/add-binding" >
								<div class="col-md-3 col-sm-6">
									<div class="form-group">
										<label class="col-md-2 control-label">Add Mac Address</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="mac_address" name="mac_address" placeholder="D4:AA:2C:B3:F1:E1">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-6">	
									<div class="form-group">
										<label class="col-md-2 control-label">Add IP Address</label>
										<div class="col-md-6">
											<input type="text" class="form-control" id="address" name="address" placeholder="192.168.1.1">
										</div>
									</div>
								</div>
								<div class="col-md-3 col-sm-6">
									<div class="form-group">
										<label class="col-md-2 control-label">Server</label>
										<div class="col-md-6">
											<select id="server" name="server" class="form-control" required>
												<option value="all">ALL</option>
											{foreach $server as $hs_server}
												<option value="{$hs_server['name']}">{$hs_server['name']}</option>
											{/foreach}	
											</select>
										</div>
									</div>	
								</div>
								<div class="col-md-3 col-sm-6">
									<div class="form-group">
										<label class="col-md-2 control-label">Binding Type</label>
										<div class="col-md-6">
											<select id="type" name="type" class="form-control" required>
												<option value="" selected>- select binding type -</option>
												<option value="bypassed">BYPASSED</option>
												<option value="regular">REGULAR</option>
												<option value="blocked">BLOCKED</option>
											</select>
										</div>
									</div>
								</div>	
								<div class="form-group">
									<label class="col-md-2 control-label">Comment</label>
									<div class="col-md-6">
										<input type="text" class="form-control" id="comment" name="comment" placeholder="comment">
									</div>
								</div>									
								<hr/>
								<div>									
									<button style="width:131px" class="btn btn-success waves-effect waves-light" name="add" type="submit">Add IP Binding</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>	
			<!--modal add binding -->
	
{include file="sections/footer.tpl"}
