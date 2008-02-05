Subject: RE: Accurately setting Security Context of a  user when ssh-ing in
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
Cc: Dave Quigley <dpquigl@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D04568692@de01exm68.ds.mot.com>
References: <4784EFE8.9050106@redhat.com>
	 <6FE441CD9F0C0C479F2D88F959B015880153F49C@exchange.columbia.tresys.com>
	 <1199903006.9393.296.camel@moss-spartans.epoch.ncsc.mil>
	 <478670A8.5080902@redhat.com> <1199995291.3707.15.camel@vogon>
	 <47877F43.5030401@redhat.com>
	 <1200065528.29816.66.camel@moss-spartans.epoch.ncsc.mil>
	 <1200065923.29816.69.camel@moss-spartans.epoch.ncsc.mil>
	 <4787BF20.1050105@redhat.com> <47A08F44.20308@redhat.com>
	 <D06FE0A2807BC145B0D38744789D4F5D0451FF16@de01exm68.ds.mot.com>
	 <1201739450.24702.488.camel@moss-terrapins.epoch.ncsc.mil>
	 <D06FE0A2807BC145B0D38744789D4F5D04568692@de01exm68.ds.mot.com>
Content-Type: text/plain
Date: Tue, 05 Feb 2008 08:01:39 -0500
Message-Id: <1202216499.27371.2.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-02-04 at 19:44 -0500, Hasan Rezaul-CHR010 wrote:
> Hi Dave,
> 
> I forgot to mention that, after doing the un-tarring of the policy
> collection, I did run the restorecon command:
> 
> restorecon -rF /
> restorecon -rF /etc/
> 
> And I did try running    /usr/sbin/load_policy
> 
> ... If I ssh in as Admin, I still get the wrong user context of
> staff_u:sysadm_r:sysadm_t:s0    :-(
> 
> But if I reboot the machine, and then ssh in as Admin, I get the correct
> user context of  staff_u:staff_r:staff_t  !!
> 
> Is there any other hidden thing that the reboot does that helps in
> setting the user contexts correctly ?
> 
> Thanks again for all the help...

The logic for computing the login context for users is based on the
context of the caller (e.g. the context in which the login process runs)
as well as the authorized contexts for the user.  For example, policy
might allow a user to login at the console (local_login_t) as sysadm_r
while preventing him from logging in directly into sysadm_r when logging
in via ssh (sshd_t).

Thus, if you merely untar the directory, reload policy, and relabel,
your existing processes may still be running in the wrong contexts, and
this can affect the context computed for login.  A reboot ensures that
everything transitions properly as defined by policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
