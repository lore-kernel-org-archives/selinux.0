MIME-Version: 1.0
From: William Roberts <bill.c.roberts@gmail.com>
Date: Tue, 25 Oct 2016 09:12:38 -0700
Message-ID: <CAFftDdrPRK==xJaXoLq10nLS2k9wxe3WmqSjHFJAGu0+mYvL0A@mail.gmail.com>
Subject: Android Fork Dies on AOSP
To: "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In this commit, external/libselinux goes away:
https://android-review.googlesource.com/#/c/293506

Now, AOSP is using upstream selinux in external/selinux plus the following:
src/android
include/selinux/android.h

More details can be found here:
https://android.googlesource.com/platform/external/selinux/+/master/README.android

This essentially closes a lot of the headaches updating libselinux on
Android, but granted, the title of this email is a misnomer, a
technical fork still exists, but for libselinux, it is all self
contained in stand alone files, and thus no merge headaches on
updates.

A big thanks goes to Jeff V for finalizing my work and getting it
merged, thanks Jeff!

-- 
Respectfully,

William C Roberts
