Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3RKCIgA019593
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2005 16:12:18 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3RKC4ES024988
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2005 20:12:04 GMT
Subject: Re: /tmp
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
In-Reply-To: <1114610963.21998.25.camel@localhost.localdomain>
References: <1114610043.21998.16.camel@localhost.localdomain>
	 <1114610963.21998.25.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-kkTh5fgcOr3MpYr7sVBz"
Date: Wed, 27 Apr 2005 16:11:53 -0400
Message-Id: <1114632714.25367.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-kkTh5fgcOr3MpYr7sVBz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> So couldn't a new expansion be added called USER that expands to the
> corresponding user name?

Patch attached for USER expansion. Not sure if it belongs in this
script, but it does what I want :) 

Next...selinux profile script to create the /tmp folders every time.

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-kkTh5fgcOr3MpYr7sVBz
Content-Disposition: attachment; filename=genhomedircon.diff
Content-Type: text/x-patch; name=genhomedircon.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- genhomedircon	2005-04-27 15:26:47.000000000 -0400
+++ genhomedircon.new	2005-04-27 16:01:36.000000000 -0400
@@ -357,16 +357,22 @@
 		return udict
 
 	def getHomeDirContext(self, user, home, role):
-		ret="\n\n#\n# Context for user %s\n#\n\n" % user
+		ret="\n\n#\n# Home Context for user %s\n#\n\n" % user
 		rc=commands.getstatusoutput("grep '^HOME_DIR' %s | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), home, role, user))
 		return ret + rc[1] + "\n"
 
+	def getUserContext(self, user, role):
+		ret="\n\n#\n# Other Context for user %s\n#\n\n" % user
+		rc=commands.getstatusoutput("grep 'USER' %s | sed -e 's/USER/%s/' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), user, role, user))
+		return ret + rc[1] + "\n"
+
 	def genHomeDirContext(self):
 		users = self.getUsers()
 		ret=""
 		# Fill in HOME and ROLE for users that are defined
 		for u in users.keys():
 			ret += self.getHomeDirContext (u, users[u]["home"], users[u]["role"])
+			ret += self.getUserContext (u, users[u]["role"])
 		return ret+"\n"
 
 	def checkExists(self, home):

--=-kkTh5fgcOr3MpYr7sVBz
Content-Disposition: attachment; filename=Makefile.diff
Content-Type: text/x-patch; name=Makefile.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- Makefile	2005-04-27 16:02:07.000000000 -0400
+++ Makefile.new	2005-04-27 16:02:50.000000000 -0400
@@ -221,7 +221,7 @@
 	@echo "Building file contexts files..."
 	@m4 $(M4PARAM) $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) > $@.tmp
 	@grep -v -e HOME -e ROLE $@.tmp > $@
-	@grep -e HOME -e ROLE $@.tmp  > $(HOMEDIR_TEMPLATE)
+	@grep -e HOME -e ROLE -e USER $@.tmp  > $(HOMEDIR_TEMPLATE)
 	@-rm $@.tmp
 
 # Create a tags-file for the policy:

--=-kkTh5fgcOr3MpYr7sVBz--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
