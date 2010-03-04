Subject: Re: I think this might be a bug.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>
In-Reply-To: <1267734243.23761.180.camel@moss-pluto.epoch.ncsc.mil>
References: <4B8FFEA9.9090800@redhat.com>
	 <1267734243.23761.180.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 04 Mar 2010 15:38:47 -0500
Message-Id: <1267735127.23761.184.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-03-04 at 15:24 -0500, Stephen Smalley wrote:
> On Thu, 2010-03-04 at 13:40 -0500, Daniel J Walsh wrote:
> > If I have a program that calls setfscreatecon on a directory that has a 
> > transition, the transition rule wins.  I think the setfscreatecon should 
> > win.
> > 
> > Sandbox creates a .sandboxRANDOM directory in the current working 
> > directory with setfscreatecon, If I do this in ~dwalsh  It does not 
> > work.  If I do it in ~dwalsh/.sandbox or /tmp or any directory other 
> > then my homedir toplevel it works.
> > 
> > Here is a python script that shows the behaviour
> > 
> > #!/usr/bin/python
> > from tempfile import mkdtemp
> > import selinux, os
> > selinux.setfscreatecon("staff_u:object_r:sandbox_x_file_t:s0:c1")
> > homedir = mkdtemp(dir="~/.sandbox", prefix=".sandbox")
> > print selinux.getfscreatecon()
> > print homedir
> 
> kernel version?  setfscreatecon() should work unless the filesystem does
> not support security labeling, and should override any default
> transitions in the policy. 

Confirmed on ext4; seems to work correctly on ext3.

Your python script didn't work for me, but this much simpler test does:
cd $HOME
mkdir -Z unconfined_u:object_r:etc_t:s0 bar
ls -Zd bar

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
