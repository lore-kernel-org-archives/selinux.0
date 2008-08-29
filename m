Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7TKxfxY012223
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 16:59:41 -0400
Received: from rv-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7TKx9rW003829
	for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 20:59:10 GMT
Received: by rv-out-0708.google.com with SMTP id f25so1062498rvb.54
        for <selinux@tycho.nsa.gov>; Fri, 29 Aug 2008 13:59:40 -0700 (PDT)
Message-ID: <f00ed96d0808291359n2e3a81eo5391ec2e4bb45c68@mail.gmail.com>
Date: Fri, 29 Aug 2008 16:59:40 -0400
From: Hong <kindloaf@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: About SELinux in Ubuntu
Cc: "SELinux Mailing List" <selinux@tycho.nsa.gov>,
        "Caleb Case" <ccase@tresys.com>, "Chad Sellers" <csellers@tresys.com>
In-Reply-To: <1220015196.5708.276.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_20241_22309191.1220043580638"
References: <f00ed96d0808281244x34aa8999y7add418d78687e7@mail.gmail.com>
	 <1220015196.5708.276.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_20241_22309191.1220043580638
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for your explanation Stephen.

I am not sure if the following problem is general for SELinux or specific
for refpolicy:

Now I am trying to compile the current refpolicy.  After compilation and
restart ubuntu doesn't boot.

I used "apt-get source refpolicy" to get the policy source.  Then I did
"make policy", "make load", "make restorelabels", and restarted the machine.

=8<=========================================
Starting up ...
Loading, please wait...
[   14.623245] sd 0:0:0:0: [sda] Assuming drive cache: write through
[   14.623882] sd 0:0:0:0: [sda] Assuming drive cache: write through
kinit: name_to_dev_t(/dev/disk/by-uuid/2896d9f5-f576-4f35-8abd-277710a63def)
= s
da5(8,5)
kinit: trying to resume from
/dev/disk/by-uuid/2896d9f5-f576-4f35-8abd-277710a63
def
kinit: No resume image, doing normal boot...
exec: 7: /etc/init.d/rcS: Permission denied
init: rcS main process (2326) terminated with status 2
init: rc-default main process (2328) terminated with status 1
=8<=========================================

I used ubuntu live CD and found nothing in /var/log/message.  (there is no
single entry since last boot) And if I disable SELinux by turning off the
kernel option, it can boot.
Is there any clue how to solve this problem?

Hong

On Fri, Aug 29, 2008 at 9:06 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

>
> On Thu, 2008-08-28 at 15:44 -0400, Hong wrote:
> > I am trying to use SELinux in Ubuntu 8.04.  Looks like refpolicy is
> > the only supported policy in the repository.
> > I downloaded policy.22 (refpolicy).  The size of the binary policy is
> > about 360K(accurate size is 360296), much smaller than targeted policy
> > in Fedora8. (about 3.5M).
> >
> > Then I use dispol tool in checkpolicy to display the policy, seems
> > there are no many useful domains in the policy.  There is no htttpd
> > domain, no ftpd domain...
>
> As I understand it, they only shipped a minimal policy and a cupsd
> policy module as a starting point, to match the original configuration
> of AppArmor.  I'm not sure what progress has been made since then.  You
> can of course try building and using the upstream refpolicy with a more
> complete configuration.
>
> > And the access vector really confuses me. For example, I think the
> > domain insmod_t should be entered through insmod, rmmod, ...
> > But from the policy,  domain insmod_t has the entrypoint privilege
> > over a lot of types: hplip_etc_t, lpd_tmp_t, proc_afs_t,
> > pam_tmp_t, ... (there are more than 300 of them).
> >
> > Did I do anything wrong?  And if I am getting the correct binary
> > policy, why the entrypoint privilege is configure this way?
>
> I'd guess that insmod_t is an unconfined domain in that policy (typical
> for a targeted-style policy), and thus is unrestricted.
>
> --
> Stephen Smalley
> National Security Agency
>
>

------=_Part_20241_22309191.1220043580638
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Thanks for your explanation Stephen.<br><br>I am not sure if the following problem is general for SELinux or specific for refpolicy:<br><br>Now I am trying to compile the current refpolicy.&nbsp; After compilation and restart ubuntu doesn&#39;t boot.<br>
<br>I used &quot;apt-get source refpolicy&quot; to get the policy source.&nbsp; Then I did &quot;make policy&quot;, &quot;make load&quot;, &quot;make restorelabels&quot;, and restarted the machine.<br>
<br>=8&lt;=========================================<br><div dir="ltr">Starting up ...<br>Loading, please wait...<br>[&nbsp;&nbsp; 14.623245] sd 0:0:0:0: [sda] Assuming drive cache: write through<br>
[&nbsp;&nbsp; 14.623882] sd 0:0:0:0: [sda] Assuming drive cache: write through<br>kinit: name_to_dev_t(/dev/disk/by-uuid/2896d9f5-f576-4f35-8abd-277710a63def) = s<br>da5(8,5)<br>kinit: trying to resume from /dev/disk/by-uuid/2896d9f5-f576-4f35-8abd-277710a63<br>

def<br>kinit: No resume image, doing normal boot...<br>exec: 7: /etc/init.d/rcS: Permission denied<br>init: rcS main process (2326) terminated with status 2<br>init: rc-default main process (2328) terminated with status 1<br>

=8&lt;=========================================<br><br>I
used ubuntu live CD and found nothing in /var/log/message.&nbsp; (there is
no single entry since last boot) And if I disable SELinux by turning
off the kernel option, it can boot.<br>
Is there any clue how to solve this problem?<br><br>Hong<br></div><br><div class="gmail_quote">On Fri, Aug 29, 2008 at 9:06 AM, Stephen Smalley <span dir="ltr">&lt;<a href="mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d"><br>
On Thu, 2008-08-28 at 15:44 -0400, Hong wrote:<br>
&gt; I am trying to use SELinux in Ubuntu 8.04. &nbsp;Looks like refpolicy is<br>
&gt; the only supported policy in the repository.<br>
&gt; I downloaded policy.22 (refpolicy). &nbsp;The size of the binary policy is<br>
&gt; about 360K(accurate size is 360296), much smaller than targeted policy<br>
&gt; in Fedora8. (about 3.5M).<br>
&gt;<br>
&gt; Then I use dispol tool in checkpolicy to display the policy, seems<br>
&gt; there are no many useful domains in the policy. &nbsp;There is no htttpd<br>
&gt; domain, no ftpd domain...<br>
<br>
</div>As I understand it, they only shipped a minimal policy and a cupsd<br>
policy module as a starting point, to match the original configuration<br>
of AppArmor. &nbsp;I&#39;m not sure what progress has been made since then. &nbsp;You<br>
can of course try building and using the upstream refpolicy with a more<br>
complete configuration.<br>
<div class="Ih2E3d"><br>
&gt; And the access vector really confuses me. For example, I think the<br>
&gt; domain insmod_t should be entered through insmod, rmmod, ...<br>
&gt; But from the policy, &nbsp;domain insmod_t has the entrypoint privilege<br>
&gt; over a lot of types: hplip_etc_t, lpd_tmp_t, proc_afs_t,<br>
&gt; pam_tmp_t, ... (there are more than 300 of them).<br>
&gt;<br>
&gt; Did I do anything wrong? &nbsp;And if I am getting the correct binary<br>
&gt; policy, why the entrypoint privilege is configure this way?<br>
<br>
</div>I&#39;d guess that insmod_t is an unconfined domain in that policy (typical<br>
for a targeted-style policy), and thus is unrestricted.<br>
<font color="#888888"><br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></blockquote></div><br></div>

------=_Part_20241_22309191.1220043580638--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
