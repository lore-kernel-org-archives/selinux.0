Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6QGOkdC003191
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2007 12:24:47 -0400
Received: from mail.asahi-net.or.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6QGOhrQ008352
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2007 16:24:45 GMT
Message-ID: <46A8CAE0.7030809@kaigai.gr.jp>
Date: Fri, 27 Jul 2007 01:25:04 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: fedora-selinux-list@redhat.com
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, selinux@tycho.nsa.gov
Subject: SE-PostgreSQL for Fedora (Re: Guideline for RPM packages)
References: <46681714.3030009@kaigai.gr.jp> <1181227502.11979.24.camel@moss-spartans.epoch.ncsc.mil> <46681ED6.1010408@kaigai.gr.jp> <46A861F6.10709@ak.jp.nec.com>
In-Reply-To: <46A861F6.10709@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

By the way, I'm seeking sponsors who can review SE-PostgreSQL package.

  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=249522

If you can volunteer the reviewing process, please contact me.

Thanks,

>>>> If I remember correctly, someone posted a guideline to make
>>>> a RPM package which contains binary security policy, several
>>>> weeks ago.
>>>>
>>>> If you know the URL, would you tell me the location?
>>> There is a draft guide at:
>>> http://fedoraproject.org/wiki/PackagingDrafts/SELinux/PolicyModules
>> Thanks, so much!
> 
> I have a comment for the Policy Module Packaging Guideline.
> 
> The document says every *.pp files should be installed for any sort of policies
> (targeted, strict, mls) in the %post section.
> However, it can cause a problem when a part of policies are not installed yet.
> 
> When we try to install an application including policy package on the system
> which has only targeted policy, installation of *.pp files for strict/mls will
> be failed no need to say.
> If we want to install selinux-policy-strict or -mls later, the oraphan *.pp files
> are not linked automatically because "/usr/bin/semodule -i" is not invoked.
> It will cause a simple problem, but a bit difficult to find out.
> 
> I have an idea that uses "%triggerin" to invoke "/use/bin/semodule -i" to link
> orphan *.pp files on instllation of selinux-policy-* packages later, as follows:
> 
> ----------------
>   %triggerin -- selinux-policy-targeted
>   if [ $0 -eq 1 ]; then
>       /usr/sbin/semodule -s targeted -i %{_datadir}/selinux/targeted/mymodule.pp &> /dev/null || :
>   fi
>   %triggerin -- selinux-policy-strict
>   if [ $0 -eq 1 ]; then
>       /usr/sbin/semodule -s strict -i %{_datadir}/selinux/strict/mymodule.pp &> /dev/null || :
>   fi
>   %triggerin -- selinux-policy-mls
>   if [ $0 -eq 1 ]; then
>       /usr/sbin/semodule -s mls -i %{_datadir}/selinux/mls/mymodule.pp &> /dev/null || :
>   fi
> ----------------
> 
> If the application is installed on the system which already has selinux-policy-strict,
> "%triggerin -- selinux-policy-strict" will be invoked just when the application is
> installed, so there is no degrading.
> 
> Thanks,

--
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
