Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4C49AGg028860
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 00:09:10 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4C4996C011497
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 04:09:09 GMT
Received: by wr-out-0506.google.com with SMTP id 68so264941wri
        for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 21:09:09 -0700 (PDT)
Message-ID: <a9951d2a0605112109p2d71d57ege0ca5190635ce5da@mail.gmail.com>
Date: Fri, 12 May 2006 12:09:09 +0800
From: "Rogelio Serrano" <rogelio.serrano@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: pam_namespace
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1147355821.17252.2.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200605051623.25533.russell@coker.com.au>
	 <a9951d2a0605110645v42cb9987ucb697d866cae8960@mail.gmail.com>
	 <1147355821.17252.2.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 5/11/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Thu, 2006-05-11 at 21:45 +0800, Rogelio Serrano wrote:
> > separate namespaces is somewhat similar to selinux/dte and clashes
> > with it. i dont think we can mix selinux with separate namespaces as
> > it is right now.
>
> I think there is a misunderstanding - Linux namespaces do not
> clash/conflict with SELinux at all, and pam_namespace is a mechanism for
> using Linux namespaces and bind mounts to provide similar functionality
> to multi-level directories in SELinux.
>

Well it would not unless you consider namespace as an analog of a
coarse grained "domain" in dte. In a namespace experiment a while ago
the users were isolated from each other using namespaces but they had
no way of "transitioning" to other namespaces.

> --
> Stephen Smalley
> National Security Agency
>
>


-- 
www.smsglobal.net SMS Global Ltd Short Message Service For Seafarers


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
