Message-ID: <3B7D69CD.2EC446B1@earthlink.net>
Date: Fri, 17 Aug 2001 12:00:29 -0700
From: John Scroggins <dataefx@earthlink.net>
MIME-Version: 1.0
To: "Benjamin D. Thomas" <ben@linuxsecurity.com>
CC: Christopher Mahmood <ckm@suse.com>,
        "SELinux@tycho.nsa.gov" <SELinux@tycho.nsa.gov>
Subject: Re: [Fwd: Partial TOC for Comment]
References: <20010817172038.46E2811D317@juggernaut.guardiandigital.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Benjamin D. Thomas" wrote:
> 
> > In summary, I think you need to tell not only how to set it up
> > and configure it and what the theory is behind it, but also
> > how to use it.
> 
> Yes, agreed.  I like the format of the document and what you have is
> great.  I just think it is missing sections on installation,
> configuration, and common issues.  I realize that documents of this sort
> have been written, but they should be compiled into this single document.
> 
> Thanks,
> 
> Ben

Thanks, all this input is great.. 

I was thinking along these lines -- due to the fact that SELinux already
has an INSTALL document, I was talking with a few people about scripting
a major portion of the commands, then possibly have some one work one a
UI similar to the kernel menuconfig dialog screen for editing the policy
files. I also believe this is the place to add the following items:

1) Getting the Kernel Source 
2) Editing the Policy Files (integrate the UI feature here) 
3) Building the Kernel (scripted to a single command like Debian
"makekpkg") and Related Tools
4) Relabeling the Filesystem (have a script which parses the contents of
the default file vs. current filesystem and edits or deletes the
appropriate entries) 

If we can get these to fly, then the amount of redundancy would be
limited.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
