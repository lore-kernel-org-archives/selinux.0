Message-ID: <1340626369.22057.29.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] hiding SELinux status on Settings app if
 HAVE_SELINUX:=false
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Date: Mon, 25 Jun 2012 08:12:49 -0400
In-Reply-To: <CAFftDdqF5WPAx3ESGbzFFaXvW8jb5Qxsk6oqz-f47UH3fqQkyA@mail.gmail.com>
References: 
	<CAFftDdqF5WPAx3ESGbzFFaXvW8jb5Qxsk6oqz-f47UH3fqQkyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-06-22 at 13:43 -0700, William Roberts wrote:
> This should hide the SELinux status in settings if you don't have
> HAVE_SELINUX:=true during the build.
> 
> 
> Please verify these patches before merging them. I only tested on
> Maguro.
> 
> 
> Right now, you must do a CLEAN build to get these to work right. For
> some reason props doesn't get updated right for me.
> 
> 
> These for addressing the issues in Change-Id:
> I69529fb7a3adfe31eccb16d79740fc4952ff5e68 on garret

I was going to just drop the Settings app change since we now have
SEAndroidManager and it provides a superset of the Settings app
functionality (and has the benefit of being easily included/excluded in
different product builds).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
