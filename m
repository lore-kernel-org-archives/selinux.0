Message-ID: <4242CABC.70400@redhat.com>
Date: Thu, 24 Mar 2005 09:12:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: I would like to propose some kind of consolidation of tmpfs_t and
 tmp_t
Content-Type: multipart/mixed;
 boundary="------------090608050209020005000806"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090608050209020005000806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

We are seeing a growing amount of bug reports on using the /tmp 
directory as a tmpfs_t file system.  Do we need to have
two separate types? Can I make the following change?
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te 
policy-1.23.4/macros/global_macros.te
--- nsapolicy/macros/global_macros.te   2005-03-24 08:58:29.000000000 -0500
+++ policy-1.23.4/macros/global_macros.te       2005-03-23 
12:36:36.000000000 -0500
@@ -418,8 +418,8 @@
 define(`tmp_domain', `
 type $1_tmp_t, file_type, sysadmfile, tmpfile $2;
 ifelse($3, `',
-`file_type_auto_trans($1_t, tmp_t, $1_tmp_t, `{ file dir }')',
-`file_type_auto_trans($1_t, tmp_t, $1_tmp_t, `$3')')
+`file_type_auto_trans($1_t, { tmpfs_t tmp_t }, $1_tmp_t, `{ file dir }')',
+`file_type_auto_trans($1_t, { tmpfs_t tmp_t }, $1_tmp_t, `$3')')
 ')

There are a few places where this conflicts such as apache where it 
calls tmpfs_domain.  But that looks
like
+`file_type_auto_trans($1_t, tmpfs_t, $1_tmpfs_t, `$3')')
Is there anything significant about this differenct.  Or can we just 
eliminate $1_tmpfs_t stuff?

Using mount -fscontext=tmp_t does not work because of other problems.


Dan

-- 



--------------090608050209020005000806
Content-Type: message/rfc822;
 name="Re: using tmpfs for /tmp and selinux"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: using tmpfs for /tmp and selinux"

Return-Path: <fedora-selinux-list-bounces@redhat.com>
Received: from mail.boston.redhat.com ([unix socket])
	by mail.boston.redhat.com (Cyrus v2.1.12) with LMTP; Thu, 24 Mar 2005 08:25:28 -0500
X-Sieve: CMU Sieve 2.2
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j2ODPSv8011377;
	Thu, 24 Mar 2005 08:25:28 -0500
Received: from mx1.util.phx.redhat.com (mx1.util.phx.redhat.com [10.8.4.92])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j2ODPMO24776;
	Thu, 24 Mar 2005 08:25:22 -0500
Received: from hormel.redhat.com (hormel.util.phx.redhat.com [10.8.4.111])
	by mx1.util.phx.redhat.com (8.11.6/8.11.6) with ESMTP id j2ODPLk12311;
	Thu, 24 Mar 2005 08:25:21 -0500
Received: from listman.util.phx.redhat.com (listman.util.phx.redhat.com [10.8.4.110])
	by hormel.redhat.com (Postfix) with ESMTP
	id B7B4273617; Thu, 24 Mar 2005 08:25:20 -0500 (EST)
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by listman.util.phx.redhat.com (8.12.11/8.12.10) with ESMTP id
	j2ODPIpO013004 for <fedora-selinux-list@listman.util.phx.redhat.com>;
	Thu, 24 Mar 2005 08:25:18 -0500
Received: from mx1.redhat.com (mx1.redhat.com [172.16.48.31])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j2ODPIO24760
	for <fedora-selinux-list@redhat.com>; Thu, 24 Mar 2005 08:25:18 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j2ODPGum021492
	for <fedora-selinux-list@redhat.com>; Thu, 24 Mar 2005 08:25:16 -0500
Received: from tycho.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2ODMXQL005244
	for <fedora-selinux-list@redhat.com>; Thu, 24 Mar 2005 13:22:33 GMT
Received: from moss-spartans.epoch.ncsc.mil (moss-spartans [144.51.25.121])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2ODPFDo000961
	for <fedora-selinux-list@redhat.com>;
	Thu, 24 Mar 2005 08:25:16 -0500 (EST)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>
In-Reply-To: <42426FAD.40109@feuerpokemon.de>
References: <42415CF0.6010102@feuerpokemon.de>
	<1111583217.21107.9.camel@moss-spartans.epoch.ncsc.mil>
	<42426FAD.40109@feuerpokemon.de>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 24 Mar 2005 08:17:27 -0500
Message-Id: <1111670247.12486.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
X-RedHat-Spam-Score: 0 
X-loop: fedora-selinux-list@redhat.com
Subject: Re: using tmpfs for /tmp and selinux
X-BeenThere: fedora-selinux-list@redhat.com
X-Mailman-Version: 2.1.5
Precedence: junk
Reply-To: "Fedora SELinux support list for users &amp;  developers." <fedora-selinux-list@redhat.com>
List-Id: "Fedora SELinux support list for users &amp;
	developers." <fedora-selinux-list.redhat.com>
List-Unsubscribe: <http://www.redhat.com/mailman/listinfo/fedora-selinux-list>,
	<mailto:fedora-selinux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/fedora-selinux-list>
List-Post: <mailto:fedora-selinux-list@redhat.com>
List-Help: <mailto:fedora-selinux-list-request@redhat.com?subject=help>
List-Subscribe: <http://www.redhat.com/mailman/listinfo/fedora-selinux-list>,
	<mailto:fedora-selinux-list-request@redhat.com?subject=subscribe>
Sender: fedora-selinux-list-bounces@redhat.com
Errors-To: fedora-selinux-list-bounces@redhat.com

On Thu, 2005-03-24 at 08:43 +0100, dragoran wrote:
> doesn't seem to work:
> Mar 24 08:35:28 chello062178124144 kernel: audit(1111649728.433:0): 
> avc:  denied  { associate } for  pid=4574 exe=/usr/bin/gdm-binary 
> name=.ICE-unix scontext=user_u:object_r:tmp_t 
> tcontext=system_u:object_r:tmp_t tclass=filesystem
> Mar 24 08:35:28 chello062178124144 kernel: audit(1111649728.433:0): 
> avc:  denied  { associate } for  pid=4574 exe=/usr/bin/gdm-binary 
> name=.X11-unix scontext=user_u:object_r:tmp_t 
> tcontext=system_u:object_r:tmp_t tclass=filesystem
> Mar 24 08:35:28 chello062178124144 kernel: audit(1111649728.433:0): 
> avc:  denied  { associate } for  pid=4574 exe=/usr/bin/gdm-binary 
> name=.X11-unix scontext=user_u:object_r:tmp_t 
> tcontext=system_u:object_r:tmp_t tclass=filesystem
> Mar 24 08:35:31 chello062178124144 kernel: audit(1111649731.447:0): 
> avc:  denied  { associate } for  pid=5340 exe=/usr/X11R6/bin/Xorg 
> name=.tX0-lock scontext=user_u:object_r:tmp_t 
> tcontext=system_u:object_r:tmp_t tclass=filesystem

Ah, yes - you would need policy changes as well, e.g.
	allow tmpfile tmp_t:filesystem associate;

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency

--
fedora-selinux-list mailing list
fedora-selinux-list@redhat.com
http://www.redhat.com/mailman/listinfo/fedora-selinux-list

--------------090608050209020005000806--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
