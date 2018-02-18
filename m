Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1IIKQCq018122
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 13:20:26 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 3zkwCc70Nkz19Ytj
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 18:20:12 +0000 (UTC)
Received: from UPBD19PA03.eemsg.mil (unknown [192.168.18.4])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 3zkwCc6DYbz19Ytg
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 18:20:12 +0000 (UTC)
Received: from mail-lf0-f47.google.com (mail-lf0-f47.google.com
 [209.85.215.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 025F856126C
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 19:20:04 +0100 (CET)
Received: by mail-lf0-f47.google.com with SMTP id x196so10188614lfd.12
 for <selinux@tycho.nsa.gov>; Sun, 18 Feb 2018 10:20:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJfZ7==9Xj-dXKygmcc2u5o811mA35JUv_9jtaHJu4TPXewB0A@mail.gmail.com>
References: <20180214095337.1945-1-plautrba@redhat.com>
 <CAJfZ7==9Xj-dXKygmcc2u5o811mA35JUv_9jtaHJu4TPXewB0A@mail.gmail.com>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Sun, 18 Feb 2018 19:20:02 +0100
Message-ID: <CAJfZ7==fjyC6Uh9CGJ=rqc+uG1MZt08AgPv5PY6V-rx23Dtz3w@mail.gmail.com>
To: Petr Lautrbach <plautrba@redhat.com>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: Update selinux-sepolgengui to be compatible with Gtk3, Python 3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Feb 18, 2018 at 7:09 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> On Wed, Feb 14, 2018 at 10:53 AM, Petr Lautrbach <plautrba@redhat.com> wrote:
>> Hi,
>>
>> The following set of patches update polgengui.py, rename polgen.glade to
>> polgen.ui, convert it to new format, and fix some other sepolicy Python 3
>> related issues.
>
> Hi,
> I have read and tested these patches and they look good to me.
(Oops, the mail has been sent before I finished writing it...)

In order to run polgengui on my development system which uses a policy
without MLS, I needed a patch in sepolicy, that I sent a few days ago
("[PATCH 1/3] python/sepolicy: Support non-MLS policy"). With this I
have been able to play with polgengui and have been surprised by a
warning which appears on my terminal every time I type anything in the
"name" field of the form in the second tab ("Enter name of application
or user role:"):

polgengui.py:778: Warning: g_value_get_int: assertion
'G_VALUE_HOLDS_INT (value)' failed
  Gtk.main()

Have you got such warning on your system? Do you know where this
warning comes from? For information I use Gtk3 3.22.26 with
python-gobject 3.26.1.

Anyway, this looks like a harmless warning. Feel free to add
"Tested-by: Nicolas Iooss <nicolas.iooss@m4x.org>" to your patches.

Thanks,
Nicolas
