Subject: Re: vserver and vprocunhide
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Gil Mayol <Daniel.Gil-Mayol@brunel.de>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200610231751.50609.Daniel.Gil-Mayol@brunel.de>
References: <200610231751.50609.Daniel.Gil-Mayol@brunel.de>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 13:53:06 -0400
Message-Id: <1161625986.3316.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-23 at 17:51 +0200, Daniel Gil Mayol wrote:
> 1.)
> 
> I have read that vserver and selinux have conflicts, is that true?

Define "conflicts".  You will need to configure SELinux policy
appropriately, but I'm not aware of any fundamental conflict (e.g. there
would be a real conflict if vserver used the LSM security fields or
hooks, but it doesn't AFAIK).

> I am using a vserver and it tries to access ( to /proc/1 (init)  labelled as 
> unconfined, that means, it tries to {getattr search} over the 
> directory /proc/1 and audit show me a denied. Vprocunhide have a list of 
> directories of /proc to "unhide" for vserver. The problem is that I can't 
> add /proc/1 in vprocunhide (I receive an error when 
> start /etc/init.d/vprocunhide restart). I can't relabel /proc/1 using chcon 
> or setfiles. I can't write 
> "allow vserver_test_t unconfined_t:dir { getattr search };" 
> because there are in assert.te the following neverallow:
> 
> # Confined domains must never see unconfined domain's /proc/pid entries.
> neverallow { domain -unrestricted -snmpd_t -pegasus_t }
>  unconfined_t:dir { getattr search };
>  
> What I have done is substract also the vserver daemon:
> 
> neverallow { domain -unrestricted -snmpd_t -pegasus_t -vserver_test}
>  unconfined_t:dir { getattr search };
> 
> and then I can write 
> 
> allow vserver_test_t unconfined_t:dir { getattr search };
> 
> Don't seems very elegant this solution, is the right one?

What are your goals?  Even aside from the question of allowing the
vserver daemon to access /proc/1, why do you want to unhide /proc/1 in
the vservers?  Enabling a "confined" domain to access the /proc/pid
entries of an unconfined domain is naturally undesirable.  You could
also move init into its own domain (already true in strict policy), so
that you only have to allow access to init_t and not to all processes in
unconfined_t, but even there I have to question why you are allowing
this.

Note btw that there are different ways of configuring SELinux policy in
your environment:
- Define a single SELinux domain for each vserver, applied to all
processes in that vserver (e.g. all processes within vserver X run in
x_t, all processes within vserver Y run in y_t, ...).  This uses SELinux
just to reinforce the vserver separation.
- Define different SELinux domains for different processes within each
vserver, and use the same set of domains in all vservers (e.g. httpd
runs in httpd_t in all vservers, and ftpd runs in ftpd_t in all
vservers).  This uses SELinux just to enforce separation within the
vservers, not between them.
- Define different SELinux domains for different processes within each
vserver, and use orthogonal sets of domains for each vserver (e.g. httpd
runs in httpd_x_t in vserver X but runs in httpd_y_t in vserver Y, and
likewise for all other domains).  This uses SELinux to reinforce the
vserver separation and to enforce separation within each vserver.

> 2.) 
> Each time I try to restart the vserver daemon:
> 
> /etc/init.d/vserver_test restart
> 
> Then I see the following denied message:
> 
> Oct 23 16:45:02 cnsu kernel: audit(1161621902.211:1167): avc:  denied  
> { mounton } for  pid=9476 comm="mount" name="/" dev=hda2 ino=2 
> scontext=root:system_r:initrc_t tcontext=system_u:object_r:vprocunhide_t 
> tclass=dir
> 
> and audit2allow writes the next
> 
> allow initrc_t vprocunhide_t:dir mounton;
> 
> but when this allow is adedd and I compile I see this message
> 
> assertion on line 45221 violated by allow initrc_t vprocunhide_t:dir 
> { mounton };

And what was that assertion?  Likely just requires an attribute on
vprocunhide_t to mark it as a mount point directory.

> ----------------------------------------------------------------------------------------------
> 
> 3.)
> When I restart the dbus (messagebus) appear the following message.
> 
> Oct 23 17:50:29 cnsu dbus: Can't send to audit system: USER_AVC pid=21488 
> uid=81 loginuid=-1 message=avc:  0 AV entries and 0/512 buckets used, 
> longestchain length 0
> 
> It is not a denied, should I try to correct it?

Different kind of error - this means that dbusd could not send an audit
message to the kernel.  Do you have audit configured into your kernel?
Is this process running within a vserver?  Is the process running as
root?  Does it have the necessary capabilities to send audit messages?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
