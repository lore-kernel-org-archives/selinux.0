Subject: Re: Patch to make libselinux shut up when SELinux is disabled.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Howarth <paul@city-fan.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <48971AFA.3070708@city-fan.org>
References: <4880CFD1.1040102@redhat.com>
	 <1216402063.17602.322.camel@moss-spartans.epoch.ncsc.mil>
	 <4880D585.9000405@redhat.com>
	 <1216403646.17602.339.camel@moss-spartans.epoch.ncsc.mil>
	 <4880E5E1.8050303@redhat.com>  <48971AFA.3070708@city-fan.org>
Content-Type: text/plain
Date: Mon, 04 Aug 2008 13:51:03 -0400
Message-Id: <1217872263.27323.24.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-08-04 at 16:06 +0100, Paul Howarth wrote:
> This may present a problem for policy developers. For instance, I am 
> writing new policy for spamass-milter, which currently shares spamd_t 
> with spamassassin. I need spamass-milter to transition into a different 
> domain, so I need to specify a new context for /usr/bin/spamass-milter 
> in my policy module. This conflicts with the existing context for the 
> same file (spamd_exec_t) in the main selinux-policy-targeted package and 
> I get warnings like this on most rpm/selinux operations:
> 
> /etc/selinux/targeted/contexts/files/file_contexts: Multiple different 
> specifications for /usr/sbin/spamass-milter 
> (system_u:object_r:milter_spamass_exec_t:s0 and 
> system_u:object_r:spamd_exec_t:s0).
> 
> For whatever reason, the context from my local module "wins" and I get 
> the desired result. However, if semanage didn't allow this, I believe 
> I'd need to fork the selinux-policy package for the duration of my 
> development to prevent the unwanted context specification from being 
> used. Or is there some other way around this?

If that is the desired behavior, then I suppose we want to move up the
nodups_specs checking.  Like this:

Index: trunk/libselinux/src/label_file.c
===================================================================
--- trunk/libselinux/src/label_file.c	(revision 2938)
+++ trunk/libselinux/src/label_file.c	(working copy)
@@ -468,6 +468,11 @@
 					 pass, ++lineno) != 0)
 				goto finish;
 		}
+		if (pass == 1) {
+			status = nodups_specs(data, path);
+			if (status)
+				goto finish;
+		}
 		lineno = 0;
 		if (homedirfp)
 			while (getline(&line_buf, &line_len, homedirfp) > 0
@@ -507,10 +512,6 @@
 	}
 	free(line_buf);
 
-	status = nodups_specs(data, path);
-	if (status)
-		goto finish;
-
 	/* Move exact pathname specifications to the end. */
 	spec_copy = malloc(sizeof(spec_t) * data->nspec);
 	if (!spec_copy)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
