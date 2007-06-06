Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l56KCvha000879
	for <selinux@tycho.nsa.gov>; Wed, 6 Jun 2007 16:12:57 -0400
Message-ID: <46671547.5010604@tycho.nsa.gov>
Date: Wed, 06 Jun 2007 16:12:55 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 1/5] libselinux: rename existing name<->value functions
 for	compat
References: <1181157051.6578.36.camel@sgc.columbia.tresys.com>
In-Reply-To: <1181157051.6578.36.camel@sgc.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:

[snip]

> -const char *security_class_to_string(security_class_t tclass)
> +static const char *security_class_to_string_compat(security_class_t tclass)
>  {
>  	tclass = (tclass > 0 && tclass < NCLASSES) ? tclass : 0;
>  	return class_to_string_data.str + class_to_string[tclass];
>  }
>  

This will have to be rebased to the errno patch r2463 in trunk.  Also, 
the behavior should be identical on the new functions (return EINVAL in 
the same manner).

This patchset should go in prior to the mapping patchset I posted today.



-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
