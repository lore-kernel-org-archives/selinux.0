Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB85oDMA006709
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 00:50:13 -0500 (EST)
Received: from smtp-bedford-dr.mitre.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB85hW5Y008548
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 05:43:32 GMT
Received: from smtp-bedford-dr.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford-dr.mitre.org (8.11.6/8.11.6) with SMTP id jB85hXA27786
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 00:43:33 -0500
Received: from smtp-bedford-dr.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford-dr.mitre.org (Postfix) with ESMTP id D906A4F8D8
	for <selinux@tycho.nsa.gov>; Thu,  8 Dec 2005 00:43:32 -0500 (EST)
Received: from imcfe2.MITRE.ORG (imcfe2.mitre.org [129.83.29.4])
	by smtp-bedford-dr.mitre.org (8.11.6/8.11.6) with ESMTP id jB85hWi27770
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 00:43:32 -0500
From: Brian Sniffen <bsniffen@mitre.org>
To: selinux@tycho.nsa.gov
Subject: ANN: Polgen 1.2 released
Date: Thu, 08 Dec 2005 00:42:56 -0500
Message-ID: <m2acfcf8kf.fsf@raven-king.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new version of MITRE's "Polgen" tool for guided automated policy
generation is now available from <http://www.mitre.org/tech/selinux/>.

The new version comes precompiled for either Fedora Core 4 or Red Hat
Rawhide.  Prominent changes:

* Several new pages in the web interface present significant
  additional information.  For example, Polgen now collects deviations
  from permissions (while studying an application run in permissive
  mode) and shows those that will persist even after patterns are
  applied.

* We've added a "CGI" pattern, providing a more flexible alternative
  to the Boolean settings for web apps that don't closely fit the
  available models

* The SE Linux-modified strace binary is now installed as 'stracesc',
  to avoid conflicts with standard strace.  Upstream strace 4.5.13 has
  been merged in.

* The conflict-reduction algorithm has been overhauled.  Polgen is now
  very conservative about overriding existing types or type
  transitions *other* than those pertaining to the application under
  study.

* New UI elements allow configuration for strict, targeted, and other
  policies (e.g., use of user_t or unconfined_t as the generic
  launching user)

Coming soon: generation of modular policy.

-- 
Brian T. Sniffen                                      bsniffen@mitre.org
The MITRE Corporation                                       781-271-2904

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
