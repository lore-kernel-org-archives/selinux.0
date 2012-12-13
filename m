Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBDFXqeB030280
	for <selinux@tycho.nsa.gov>; Thu, 13 Dec 2012 10:33:52 -0500
Message-ID: <50C9F53E.4000009@davequigley.com>
Date: Thu, 13 Dec 2012 10:33:18 -0500
From: Dave Quigley <dpquigl@davequigley.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: semanage cleanup
References: <21751d382c2cacb70f450cd1483cecdd@countercultured.net> <50C9EE3D.70902@tycho.nsa.gov>
In-Reply-To: <50C9EE3D.70902@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 12/13/2012 10:03 AM, Stephen Smalley wrote:
> On 12/12/2012 02:58 PM, David Quigley wrote:
>> I've given a few talks on SELinux over the past year and I've spoken to
>> a bunch of people on google+ about SELinux and one topic keeps coming
>> up. Many people find semanage to be large and convoluted with the help
>> text being way to large to sort through. The latter part of the
>> complaint is easy to address. The code for argument parsing in semanage
>> (last time I checked) doesn't use things like argparse. If we switched
>> it over to argparse we could get per sub-command help messages that
>> would be more useful to people when they messed up a sub-command. Would
>> anyone be opposed if I spent the time to migrate semanage argument
>> parsing and help messages over to argparse or a similar library?
>>
>> The second problem some people have is that semanage is a multiplexed
>> command. I'm not sure what the right way to approach this is. If we look
>> at other applications which are multiplexers we get a few examples.
>> Busybox is the first example and covers most of the discussion. The two
>> ways of invoking busybox is either busybox command_name arguments or
>> command_name arguments where command_name is a symlink to the busybox
>> binary. If we chose the latter way of handling it we would need to
>> decide on one of two ways of naming the sub-commands. The first method
>> would be to come up with a naming convention for the subcommands to
>> avoid collisions like selogin for semanage login or seusers for semanage
>> users etc. The second method would be to do what git use to do which is
>> prepend the tool name onto the subcommand. For example
>> semanage-fcontext, semanage-login, semanage-users etc... If we chose
>> this route then we'd need to investigate what git's reason for moving
>> away from it was and decide if it applies to our situation as well.
>>
>> If we convert over to argparse for argument parsing it should be trivial
>> to do some processing on argv[0] to extract out a subcommand from a name
>> and use the correct routines. I'm not sure that solving the second
>> problem gets us substantial gains or if having help messages that are
>> specific to each subcommand will help users more.
>>
>> Does anyone have any thoughts about this?
>
> I think having context-sensitive help (i.e. sub-command help) and
> improving the man page would be the best way of addressing it.  I don't
> think splitting them out into separate programs is useful.
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> with
> the words "unsubscribe selinux" without quotes as the message.
>

Yea I don't think separating out the commands will really gain us much. 
I wonder though if separating the man pages might though. Git man pages 
are still given to you as git-clone or git-commit etc. There could be an 
semanage manpage which has the man pages for the specific commands as 
semanage-fcontext etc. Not sure we have enough information to make it 
worth it. It would be possible to have a more indepth discussion in the 
man pages about examples and usage if they weren't all crammed into one.

Dave

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
