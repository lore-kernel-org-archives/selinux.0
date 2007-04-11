Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BJTYV2010995
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 15:29:34 -0400
Received: from an-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BJTVGQ001495
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 19:29:32 GMT
Received: by an-out-0708.google.com with SMTP id d33so326912and
        for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 12:29:31 -0700 (PDT)
Message-ID: <9f066ee90704111229n4e876e00kd5a5722ff00141ad@mail.gmail.com>
Date: Wed, 11 Apr 2007 15:29:30 -0400
From: "Mark Webb" <elihusmails@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: X server won't start using MLS policy
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1176317391.3986.44.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15185_13815286.1176319770964"
References: <9f066ee90704111136w5e98b87bxf2463754621cf6fb@mail.gmail.com>
	 <1176317391.3986.44.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_15185_13815286.1176319770964
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for getting back to me.  I have attached my /var/log/messages file.
It appears that the binaries gdm-binary and Xorg do not have proper access.

-- 
..Cheers
Mark

On 4/11/07, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Wed, 2007-04-11 at 14:36 -0400, Mark Webb wrote:
> > I have followed the instructions at
> > http://fedoraproject.org/wiki/SELinux/FedoraMLSHowto on how to install
> > the MLS policy.  I have it working under Fedora Core 6, but when I
> > boot to runlevel 5, I get an error saying that the X server cannot be
> > started.
> >
> > Does anyone know how to fix this problem?
>
> The MLS work has focused on servers to date since we need XACE/XSELinux
> fully mainstreamed before we can provide proper support on the desktop.
> So it isn't surprising that the MLS policy doesn't work with X at
> present.
>
> Do you get avc denials in your /var/log/audit/audit.log
> or /var/log/messages?
>
> If not, try installing enableaudit.pp and retrying to collect audit
> messages.
>
> I thiink there was also a post to fedora-selinux-list circa 28 Dec 2006
> by a user with a copy of changes he found necessary to the strict policy
> to get X working fully, so that might be helpful.  Not sure how many of
> those were legitimate or how many found their way into the upstream
> policy.
>
> --
> Stephen Smalley
> National Security Agency
>
>

------=_Part_15185_13815286.1176319770964
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for getting back to me.&nbsp; I have attached my /var/log/messages file.&nbsp; It appears that the binaries gdm-binary and Xorg do not have proper access.<br clear="all"><br>-- <br>..Cheers<br>Mark
<br><br><div><span class="gmail_quote">On 4/11/07, <b class="gmail_sendername">Stephen Smalley</b> &lt;<a href="mailto:sds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Wed, 2007-04-11 at 14:36 -0400, Mark Webb wrote:<br>&gt; I have followed the instructions at<br>&gt; <a href="http://fedoraproject.org/wiki/SELinux/FedoraMLSHowto">http://fedoraproject.org/wiki/SELinux/FedoraMLSHowto</a>
 on how to install<br>&gt; the MLS policy.&nbsp;&nbsp;I have it working under Fedora Core 6, but when I<br>&gt; boot to runlevel 5, I get an error saying that the X server cannot be<br>&gt; started.<br>&gt;<br>&gt; Does anyone know how to fix this problem?
<br><br>The MLS work has focused on servers to date since we need XACE/XSELinux<br>fully mainstreamed before we can provide proper support on the desktop.<br>So it isn&#39;t surprising that the MLS policy doesn&#39;t work with X at
<br>present.<br><br>Do you get avc denials in your /var/log/audit/audit.log<br>or /var/log/messages?<br><br>If not, try installing enableaudit.pp and retrying to collect audit<br>messages.<br><br>I thiink there was also a post to fedora-selinux-list circa 28 Dec 2006
<br>by a user with a copy of changes he found necessary to the strict policy<br>to get X working fully, so that might be helpful.&nbsp;&nbsp;Not sure how many of<br>those were legitimate or how many found their way into the upstream
<br>policy.<br><br>--<br>Stephen Smalley<br>National Security Agency<br><br></blockquote></div><br>

------=_Part_15185_13815286.1176319770964--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
