Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k22Jiik0019642
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 14:44:46 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k22JifE8012824
	for <selinux@tycho.nsa.gov>; Thu, 2 Mar 2006 19:44:41 GMT
Date: Thu, 2 Mar 2006 13:44:29 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Joy Latten <latten@austin.ibm.com>
Cc: selinux@tycho.nsa.gov, cpebenito@tresys.com, selinux-dev@tresys.com
Subject: Re: building base targeted policy...
Message-ID: <20060302194429.GA6656@w-m-p.com>
References: <1141318192.3075.38.camel@faith.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1141318192.3075.38.camel@faith.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Mar 02, 2006 at 10:49:52AM -0600, Joy Latten wrote:
> I downloaded the policy-src rpm in order to build a base 
> policy. I used the modules-targeted.conf. My goal is to simply add an
> interface in kernel's module for ipsec packets. I am running targeted
> policy on FC5 test3. My build.conf states I am building targeted,
> modular policy.

I'm currently using the following commands to rebuild the MLS policy,
using steps copied from the spec file. Run this from the
/usr/src/redhat/BUILD/serefpolicy-*/ directory which you get by
installing the source RPM and running "rpmbuild -bp
SPECS/selinux-policy.spec":

  RPM_SOURCE_DIR=/usr/src/redhat/SOURCES
  Args="NAME=mls TYPE=strict-mls DISTRO=redhat DIRECT_INITRC=n MONOLITHIC=n POLY=n"
  make $Args bare
  make $Args conf
  cp -f ${RPM_SOURCE_DIR}/modules-mls.conf  ./policy/modules.conf 
  cp -f ${RPM_SOURCE_DIR}/booleans-mls.conf ./policy/booleans.conf 
  make $Args base.pp
  make $Args modules
  make $Args install

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
