Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3RFg7Rb028548
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 11:42:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3RFdeW3025006
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 15:39:40 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i3RFddIx025001
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 15:39:39 GMT
Subject: Re: /etc/passwd labeling issues
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: Ed Street <edstreet@street-tek.com>, Selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200404271325.58348.russell@coker.com.au>
References: <20040426224500.7F3B83A4053@abyss.simplyaquatics.com>
	 <200404271325.58348.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1083080493.24445.117.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 27 Apr 2004 11:41:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-04-26 at 23:25, Russell Coker wrote:
> On Tue, 27 Apr 2004 08:44, "Ed Street" <edstreet@street-tek.com> wrote:
> > So we have 2 choices for our debian users.  A) Change the password, change
> 
> No, we have only one realistic choice.  To fix PAM and make it work correctly 
> as it does in Fedora.

Or use the wrapper-based approach of the older SELinux, i.e. spasswd and
friends.

As I recall, Fedora includes more than just a modified pam for this
purpose; it also required modifications to libuser, shadow-utils, and
components of util-linux to preserve contexts on /etc/passwd and
/etc/shadow.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
