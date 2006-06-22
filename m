Subject: Re: [PATCH] libselinux: add support for keycreate attribute
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: Steve G <linux_4ever@yahoo.com>
Cc: sds@tycho.nsa.gov, eparis@parisplace.org,
        David Howells <dhowells@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <20060622172536.41778.qmail@web51512.mail.yahoo.com>
References: <20060622172536.41778.qmail@web51512.mail.yahoo.com>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 13:41:11 -0400
Message-Id: <1150998071.4057.5.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve,

I'm trying to be consistent with the rest of the libselinux codebase, so
I probably shouldn't deviate too much from the files I copied.  Perhaps
these issues should be considered with respect to this whole set of
related files (get/set*con.c).  Actually, I'm a bit concerned about how
redundant these files are; I think that some of the common code should
be refactored.  However, I didn't want to make a change like that in
this patch.

On Thu, 2006-06-22 at 10:25 -0700, Steve G wrote:
> Hi,
> 
> Just a couple of comments...
> 
> diff -X dontdiff -uprN libselinux.orig/src/getkeycreatecon.c 
> libselinux/src/getkeycreatecon.c
> --- libselinux.orig/src/getkeycreatecon.c	1969-12-31 19:00:00.000000000 -0500
> +++ libselinux/src/getkeycreatecon.c	2006-06-02 09:38:23.000000000 -0400
> +int getkeycreatecon_raw(security_context_t *context)
> +{
> 
> <snip>
> +	ret = read(fd, buf, size-1);
> +	if (ret < 0)
> +		goto out2;
> 
> Shouldn't this be wrapped in a do...while loop to avoid early exit due to EINTR?
> 
> do {
>   ret = read(fd, buf, size-1);
> } while (ret < 0 && errno == EINTR);
> if (ret < 0)
>   goto out2;
> 
> +	*context = strdup(buf);
> +	if (!(*context)) {
> +		ret = -1;
> +		goto out2;
> +	}
> 
> buf was malloc'ed above...why strdup it? To me its just another chance for error.
> 
> -Steve
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
