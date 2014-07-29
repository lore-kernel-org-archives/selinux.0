MIME-Version: 1.0
From: Thomas Coudray <amanone@gmail.com>
Date: Tue, 29 Jul 2014 12:30:40 +0100
Message-ID: <CABhRnsXYfy_4y_9hXaysArQvTPrZQPqPxv0amHAjAPX=6JYWVQ@mail.gmail.com>
Subject: How to access the Access Vector Cache from a LKM?
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

I would like to get as much informations* as possible from the kernel side.
My SELinux is in permissive mode, with the standard refpolicy.
I want to trigger some alerts in the kernel to do some
kernel-introspection, using the LSM/SELinux.
i.e: when an AVC, occur, or anything pertinent to understand what
going (wrong) in the system.
How can I accomplish this? Any hints or documentation will be appreciated.
I didn't find any relevant exported functions in the
./linux/security/selinux/ to achieve this.

Thanks,

-- 
Thomas Coudray
