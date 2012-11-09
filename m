Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA9EdXcP008594
	for <selinux@tycho.nsa.gov>; Fri, 9 Nov 2012 09:39:33 -0500
Received: by mail-lb0-f181.google.com with SMTP id gg6so3333474lbb.12
        for <selinux@tycho.nsa.gov>; Fri, 09 Nov 2012 06:39:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <509C5C3F.1050800@schaufler-ca.com>
References: <50986053.9060105@schaufler-ca.com>
	<201211062144.CFB09368.JOQMFHFFVSOLtO@I-love.SAKURA.ne.jp>
	<5099BB81.6000506@schaufler-ca.com>
	<201211072215.FFD82885.HLVJFMSOOtFFOQ@I-love.SAKURA.ne.jp>
	<509C5C3F.1050800@schaufler-ca.com>
Date: Fri, 9 Nov 2012 09:39:00 -0500
Message-ID: <CACLa4ptK6U7VCUoUzuS2pC+O=AacXPJ=W0acmOE-xBDYVLkJ5w@mail.gmail.com>
Subject: Re: [PATCH v6] LSM: Multiple concurrent LSMs
From: Eric Paris <eparis@parisplace.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SE-Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Eric Paris <eparis@redhat.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Nov 8, 2012 at 8:28 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:

> How does one go about adding the hooks to the appropriate lists?
> I came up with one macro based method that made Eric's hair fall
> out, and he never even saw it.

This is your fault?  You jerk!  I want my hair back!

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
