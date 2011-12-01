Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pB1EjC8v010930
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 09:45:12 -0500
Received: from nm3.bt.bullet.mail.ukl.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id pB1EjAkR001358
	for <selinux@tycho.nsa.gov>; Thu, 1 Dec 2011 14:45:11 GMT
Message-ID: <1322750704.22080.YahooMailClassic@web87007.mail.ird.yahoo.com>
Date: Thu, 1 Dec 2011 14:45:04 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: [PATCH 1/1] libselinux - Mapped compute functions now obey deny_unknown flag
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry about the bad formatting - will try better next time.

Well the next time is now as I've just updated/written man pages for libselinux config file formats, but before I submit I will check them.

    selabel_db.5    - sepgsql_contexts
    selabel_file.5  - file_contexts, file_contexts.homedirs,
                      file_contexts.local,
                      file_contexts.subs,
                      file_contexts.subs_dist
    selabel_media.5 - media
    selabel_x.5     - x_contexts
    booleans.5
    customizable_types.5
    default_contexts.5
    default_type.5
    failsafe_context.5
    local.users.5
    removable_context.5
    securetty_types.5
    seusers.5
    virtual_domain_context.5
    virtual_image_context.5
    service_seusers.5 - those in the ./logins directory
    user_contexts.5   - those in the ./contexts/users directory

Richard

--- On Thu, 1/12/11, Eric Paris <eparis@parisplace.org> wrote:

> From: Eric Paris <eparis@parisplace.org>
> Subject: Re: [PATCH 1/1] libselinux - Mapped compute functions now obey deny_unknown flag
> To: "Richard Haines" <richard_c_haines@btinternet.com>
> Cc: selinux@tycho.nsa.gov
> Date: Thursday, 1 December, 2011, 14:15
> applied to my devel branch. 
> This one messed up the formatting, since
> you should have indented the map_decision() call after you
> put it
> 'inside' the conditional.  I fixed it before I
> applied.
> 
> -Eric




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
