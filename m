Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5CJ5E83032062
	for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 15:05:14 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5CJ5D3s011553
	for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 19:05:13 GMT
Received: by fg-out-1718.google.com with SMTP id 16so2545011fgg.40
        for <selinux@tycho.nsa.gov>; Thu, 12 Jun 2008 12:05:12 -0700 (PDT)
Message-ID: <cadfc0e40806121205w3381c32fy9aab1aee1cdf97ce@mail.gmail.com>
Date: Thu, 12 Jun 2008 14:05:12 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: dynamic security class and access vector lookup
Cc: "SELinux Mail List" <selinux@tycho.nsa.gov>
In-Reply-To: <1213296527.17842.266.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <cadfc0e40806121138x3bb0996asda149528809d4598@mail.gmail.com>
	 <1213296527.17842.266.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jun 12, 2008 at 1:48 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On Thu, 2008-06-12 at 13:38 -0500, Xavier Toth wrote:
>> I wasn't aware until yesterday that there was an API for looking up
>> security classes (selinux_set_mapping, the name of which doesn't
>> strike me as very intuitive). Can I also lookup the access vectors for
>> a class, if so how?
>
> selinux_set_mapping() does that too.  dynamic discovery of classes and
> permissions was discussed quite a bit on list.  XSELinux uses it, and so
> does SE-Postgres.
>
> --
> Stephen Smalley
> National Security Agency
>
>

I see the posting of the patch but no discussion. Yesterday Eamon
posted an example of setting the mapping of a security class but it
didn't address perms. I have some python code where I'm calling
selinux.avc_has_perm_noaudit and have been using hard coded values for
the security class and perm. I'd like to fix this code but am not sure
if this or some other capability I'm unaware of will do the trick.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
