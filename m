Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2GZBXZ007524
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 11:35:12 -0500 (EST)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2GXo4G019875
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 16:33:50 GMT
Subject: RE: dynamic context transitions - a seteuid parallel
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: James Morris <jmorris@redhat.com>
Cc: Chad Hanson <chanson@TrustedCS.com>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <Xine.LNX.4.44.0411011939350.6248-100000@thoron.boston.redhat.com>
References: 
	 <Xine.LNX.4.44.0411011939350.6248-100000@thoron.boston.redhat.com>
Content-Type: text/plain
Message-Id: <1099413079.31739.177.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 02 Nov 2004 11:31:20 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-11-01 at 19:43, James Morris wrote:
> All the more reason to make dynamic transitions an optional feature, so 
> even MLS systems can eventually switch it off.

Separate kernel config option?  Certainly feasible, but a bit ugly since
it is simply a change within the existing setprocattr hook and exported
using the existing /proc/pid/attr/current interface as opposed to a
completely new interface.  setprocattr currently returns -EACCES upon
attempts to write to /proc/pid/attr/current; we would likely want it to
return -EOPNOTSUPP or similar if the option was disabled to clearly
indicate that the failure was due to missing kernel support rather than
permission denial.

In any event, is it really an option to ultimately disable a kernel API
once it is accepted?  API/ABI compatibility seems to be a strong
requirement for the kernel...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
