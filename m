Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i88MTrrT007958
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 18:29:53 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i88MT0R0005993
	for <selinux@tycho.nsa.gov>; Wed, 8 Sep 2004 22:29:01 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 4B5A6BF28
	for <selinux@tycho.nsa.gov>; Wed,  8 Sep 2004 23:29:48 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C5B7k-00026t-9W
	for selinux@tycho.nsa.gov; Wed, 08 Sep 2004 23:41:08 +0100
Date: Wed, 8 Sep 2004 23:41:08 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: for bootsplash to operate correctly...
Message-ID: <20040908224108.GJ7717@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

... i hacked in the three following permissions:

# this is to allow splash to write to /proc/splash
allow initrc_t proc_t:file { write };


# this is for /sbin/fbresolution to write to /dev/fb0
allow initrc_t framebuf_device:t:chr_file { write };

# this is for fbmngplay to do err... *clueless*
allow initrc_t self:capability { sys_admin };

i look forward to one day writing a policy for the bootsplash
package :)

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
