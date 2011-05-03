Subject: Re: libselinux mountpoint changing patch.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
        Lennart Poettering
 <lennart@poettering.net>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <4DC02770.1040406@redhat.com>
References: <4DC01640.9000206@redhat.com>
	 <1304436800.1587.20.camel@moss-pluto>  <4DC02770.1040406@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 May 2011 13:13:20 -0400
Message-ID: <1304442800.1587.30.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index a948920..547f1eb 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -79,7 +70,7 @@ static void init_selinuxmnt(void)
 		tmp = strchr(p, ' ');
 		if (!tmp)
 			goto out;
-		if (!strncmp(tmp + 1, "selinuxfs ", 10)) {
+		if (!strncmp(tmp + 1, SELINUXFS, 10)) {
 			*tmp = '\0';
 			break;
 		}

This isn't equivalent.  I suppose you could do this:
+		if (!strncmp(tmp + 1, SELINUXFS" ", sizeof SELINUXFS)) {

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
