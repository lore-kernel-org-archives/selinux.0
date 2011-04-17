Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3HKQAkT014269
	for <selinux@tycho.nsa.gov>; Sun, 17 Apr 2011 16:26:15 -0400
Received: from mail-iw0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3HKQCnZ020108
	for <selinux@tycho.nsa.gov>; Sun, 17 Apr 2011 20:26:13 GMT
Received: by iwn2 with SMTP id 2so4244518iwn.12
        for <selinux@tycho.nsa.gov>; Sun, 17 Apr 2011 13:26:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2f3e05e6cc143592e0fc799462fd940f@countercultured.net>
References: <2f3e05e6cc143592e0fc799462fd940f@countercultured.net>
Date: Sun, 17 Apr 2011 22:26:11 +0200
Message-ID: <BANLkTim5xwpV2m8uULb1_iNw9Nr5hUCJHg@mail.gmail.com>
Subject: Re: Writing SEPostGreSQL Database Policies
From: Kohei KaiGai <kaigai@kaigai.gr.jp>
To: David Quigley <dpquigl@davequigley.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

2011/4/15 David Quigley <dpquigl@davequigley.com>:
> Are there any good examples out there of locking down a webapp's access to a
> database using SEPostGreSQL and some web language like Ruby on Rails? I
> looked at Kaigai's and the SELinux Notebook examples for sepgsql policy and
> it seems to use the types in reference policy instead of creating new types
> for objects and only provides separation through MCS. It would be nice to go
> over either an indepth example that uses different types from reference
> policy or maybe showcases locking down a specific application.
>
One matter is that we need to describe TE policy for web applications from the
scratch, because we don't have a template suitable for them.

The mod_selinux package provides the following interface to allow a set of
basic permissions to perform the supplied domain bounded to httpd_t domain.
  http://code.google.com/p/sepgsql/source/browse/trunk/mod_selinux/mod_selinux.if
However, I face to burden of its maintenance day-by-day.

If apache.if provides a few template to define web application domains,
I believe we may provide various scenario using TE rules, rather than MCS.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
