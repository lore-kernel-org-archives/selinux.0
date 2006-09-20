Subject: Re: Problem with sshd and polyinstantiation
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Cc: LSPP <redhat-lspp@redhat.com>, Janak Desai <jdesai@us.ibm.com>,
        George Wilson <ltcgcw@us.ibm.com>, selinux@tycho.nsa.gov
In-Reply-To: <p0600203ac135cffa140b@[192.168.50.32]>
References: <p0600203ac135cffa140b@[192.168.50.32]>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 16:26:37 -0400
Message-Id: <1158783997.15340.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-19 at 13:06 -0400, Rosalie Hiebel wrote:
> I have noticed that when I have polyinstantiation with the instance 
> directory contained in the base directory, then sshd fails.  It 
> appears that sshd goes through pam_namespace (which creates/mounts 
> instance directories), and then launches another sshd process which 
> also goes through pam_namespace.  The second sshd fails to stat the 
> instance directory.
> 
> So, if my namespace.conf contains the following entry,
>      /var/poly   /var/poly/poly-inst context adm
> then when I ssh in as root, two sshd processes output pam_namespace 
> messages  to /var/log/secure.  The first sshd successfully mounts the 
> instance directory, but the second sshd is unsuccessful (since it's 
> already mounted).  The second sshd outputs the following error:
>    pam_namespace(sshd:session): Error stating /var/poly/poly-inst, No 
> such file or directory
>    pam_namespace(sshd:session): Error mounting 
> /var/poly/poly-inst/root on /var/poly, No such file or directory
> 
> When I change the instance directory not to be a subdir of the base, 
> then sshd works fine.  Is this a problem with sshd or is my setup 
> incorrect ?

What happens if you put unmnt_remnt as an option after pam_namespace.so
in your /etc/pam.d/sshd file?  That is an option for programs like su
and newrole that need to unmount and re-mount the instance directory,
but may work in this situation (not sure).

If that doesn't work either, then you might have to work around it by
putting the instances outside of the base dir for now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
