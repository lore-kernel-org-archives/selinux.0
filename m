To: SELinux@tycho.nsa.gov
From: Tobias Bengfort <tobias.bengfort@posteo.de>
Subject: UPower dbus interface unavailable with enforcing SELinux
Date: Sun, 28 Sep 2014 14:33:54 +0200
Message-ID: <m08v7l$tpj$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi,

I am running SELinux on my debian wheezy laptop. I would like to be able
to suspend in a defined amount of time, say 2h. This is useful e.g. when
watching a movie and falling asleep.

Unfortunately, SELinux blocks access to UPower's dbus interface. I guess
this is because programmatic access to power control is considered
dangerous.

My current workaround is to disable SElinux whenever I want to use the
described feature. This of course is not a desirable solution.

Is what I am trying to do possible or should I just start reading books
instead of watching movies?

regard
tobias
