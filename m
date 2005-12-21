Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBLHfKXf019094
	for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2005 12:41:20 -0500 (EST)
Received: from web51510.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id jBLHfHUe002252
	for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2005 17:41:18 GMT
Message-ID: <20051221174113.9362.qmail@web51510.mail.yahoo.com>
Date: Wed, 21 Dec 2005 09:41:13 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Adding audit messge to newrole
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Chris Wright <chrisw@osdl.org>, SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1135181425.18223.72.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>Why don't you drop capabilities first, then switch to the real uid?

You answered yourself. Need setuid capabilities.

@@ -401,6 +446,8 @@ int main( int argc, char *argv[] ) {
     exit(-1);
   }
 
+  drop_capabilities();
+
   while (1) {
     clflag=getopt_long(argc,argv,"r:t:l:",long_options,&flag_index);
     if (clflag == -1)

Any reason we can't move this up earlier in main()?

I suppose we could move it above the selinux enabled call.

>Ideally, it should be the first thing in main() to ensure that everything 
>else runs under the caller's uid as before.

But after the bindtext call for localization?

>@@ -753,6 +799,23 @@ int main( int argc, char *argv[] ) {
>        fprintf(stderr, _("Could not set exec context to %s.\n"), >new_context);
>        exit(-1);
>   }
>+  /* Send audit message */
>+  {
>+    char msg[128];  /* This number is a guess */
>
>Why not just dynamically allocate the msg buffer to be of the right
>size?

I generally prefer to use the stack on small programs. Its less complicated and
runs faster. We aren't short for stack space in this program. My comment may be
misleading you. i wanted to say that its an arbitrary number and can be changed
if someone decideds its safe to make it bigger or smaller. Is there a define that
has the maximum string representation of a context?

>Also, I think that the audit-related code should be separately #ifdef'd
>and made optional (and newrole shouldn't be made setuid unless building
>with that option). 

I can do that. I didn't want to clutter the patch on the first go around. I knew
there would be changes to it.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
