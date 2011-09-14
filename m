MIME-Version: 1.0
In-Reply-To: <1316026239-27148-1-git-send-email-eparis@redhat.com>
References: <1316026239-27148-1-git-send-email-eparis@redhat.com>
Date: Wed, 14 Sep 2011 15:14:00 -0400
Message-ID: <CACLa4ptONKKd2t6eM+CUPeWOWKjrCteiZFFTYYTRwCKiHfROog@mail.gmail.com>
Subject: Re: [PATCH 1/2] libselinux: put libselinux.so.1 in /lib not /usr/lib
From: Eric Paris <eparis@parisplace.org>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, guido@trentalancia.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 14, 2011 at 2:50 PM, Eric Paris <eparis@redhat.com> wrote:
> Commit 874bac80bbfbf0a5 incorrectly changed the default install location
> of libselinux.so.1 from /lib to /usr/lib.  This patch fixes that problem
> by reverting that portion of the change.
>
> Signed-off-by: Eric Paris <eparis@redhat.com>

Side note: with this patch the current master branch will again build
properly with DESTDIR= and install.  (using install instead of the
default target it still required)

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
