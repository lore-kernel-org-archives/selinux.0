Subject: Re: [Fwd: Latest Diff]
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <1115485468.21610.8.camel@localhost.localdomain>
References: <427A757F.9040009@redhat.com>
	 <1115344683.15149.11.camel@localhost.localdomain>
	 <1115393991.17301.18.camel@localhost.localdomain>
	 <200505072351.04728.russell@coker.com.au>
	 <1115485468.21610.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 07 May 2005 15:50:25 -0400
Message-Id: <1115495425.20062.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-05-07 at 13:04 -0400, Ivan Gyurdiev wrote:
> > One possibility would be to allow tmpwatch to go through user (not sysadm) 
> > home directories but not have search access to home_root_t.  But this makes 
> > the protection of user home directories from tmpwatch dependant on the label 
> > of home_root_t, I'm not certain that in all cases of automounting and strange 
> > configuration of home directories we can rely on the label of home_root_t 
> > being assigned to /home to protect sub-directories.
> 
> I am a bit confused - /tmp/orbit-$USER is not in /home...
> I was just wondering whether the orbit folder should be allowed to
> be erased by tmpwatch due to inactivity... If so, it will need to 
> be recreated (without rebooting), and that's why I was saying that
> in that case, libORBit probably needs to set the correct context itself,
> as opposed to a startup script solution that creates this folder.
> 
> There is no problem as far as tmpwatch goes - I can just mark the type
> tmpfile, I guess.

Patch for ORBit2 here - see the last attachment:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155800

I think I should submit the ORBit part of this patch for inclusion...

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
