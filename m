Subject: Re: I think this might be a bug.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4B8FFEA9.9090800@redhat.com>
References: <4B8FFEA9.9090800@redhat.com>
Content-Type: text/plain
Date: Thu, 04 Mar 2010 15:24:03 -0500
Message-Id: <1267734243.23761.180.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-03-04 at 13:40 -0500, Daniel J Walsh wrote:
> If I have a program that calls setfscreatecon on a directory that has a 
> transition, the transition rule wins.  I think the setfscreatecon should 
> win.
> 
> Sandbox creates a .sandboxRANDOM directory in the current working 
> directory with setfscreatecon, If I do this in ~dwalsh  It does not 
> work.  If I do it in ~dwalsh/.sandbox or /tmp or any directory other 
> then my homedir toplevel it works.
> 
> Here is a python script that shows the behaviour
> 
> #!/usr/bin/python
> from tempfile import mkdtemp
> import selinux, os
> selinux.setfscreatecon("staff_u:object_r:sandbox_x_file_t:s0:c1")
> homedir = mkdtemp(dir="~/.sandbox", prefix=".sandbox")
> print selinux.getfscreatecon()
> print homedir

kernel version?  setfscreatecon() should work unless the filesystem does
not support security labeling, and should override any default
transitions in the policy. 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
