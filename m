MIME-Version: 1.0
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Sep 2016 16:27:30 -0400
Message-ID: <CAFftDdqOWmwCihg4ujOz0qm3xWhRiTTT8dnD2dTPd-a903Ntkw@mail.gmail.com>
Subject: [RFC] Build ANDROID_HOST=y on mac
To: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

>From commit 35d702 on https://github.com/williamcroberts/selinux/tree/fix-mac

I have a branch that is building on my elcapitan mac, requesting any
comments anyone
wishes to make, before I send them out.

If you wish to test, this is the procedure

1. Build libsepol (assumes at root of tree)
    a,  cd libsepol
    b. make
2. Build libselinux
    a. cd libselinux (assumes at root of tree)
    b. make ANDROID_HOST=y

This essentially gets us to where a build server/maintainer
can test patches quickly on mac, with some assurance
it's not busted without downloading all of Android.

It's still wise to check in an Android tree if possible IMHO.

-- 
Respectfully,

William C Roberts
