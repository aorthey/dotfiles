// Plugin that adds access to stumbleupon friend capabilities
//
// @version 0.1.2
// @author Karl Möller, with modifications by Félix Sipma
//
// Tested with Vimperator 3.3
// Tested with StumbleUpon 3.95
//
// Usage:
//
// stu[mble]send <friend>
// Send the current tab to a friend
//
// Pressing <tab> while typing the friend's username will tabcomplete
//
commands.addUserCommand(["stumblesend", "susend"],
	"Send the current page to a friend \(StumbleUpon\)",
	function(friend) { 
		StumbleGlobals.sendto(friend); 
	},
	{
		completer: function (context, args) {
			var friends = StumbleGlobals.ds.selectAllRows("contact");
			var completions = [];
			for(var i = 0; i < friends.length; i++)
			{   
				if(friends[i].mutual)
					completions.push([friends[i].nickname]);
			}   
			context.title=["StumbleUpon Friends"];
			context.completions = completions;
		}
	}); 