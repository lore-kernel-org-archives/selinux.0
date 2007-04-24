Message-ID: <462E1745.8050608@redhat.com>
Date: Tue, 24 Apr 2007 10:42:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to correct genhomedircon homedir labeling.
Content-Type: multipart/mixed;
 boundary="------------070409040407080804080509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070409040407080804080509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

semanage can change the __default__ login mapping command to a user 
other than user_u.  This patch will cause genhomedircon to use this 
setting rather than currently always using user_u.

semanage login -m -s staff_u __default__


Should cause all login accounts added by useradd to use staff_home* by 
default.

--------------070409040407080804080509
Content-Type: text/x-patch;
 name="genhomedircon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="genhomedircon.patch"

--- nsapolicycoreutils/scripts/genhomedircon	2007-04-24 10:36:17.000000000 -0400
+++ policycoreutils-2.0.9/scripts/genhomedircon	2007-04-20 13:58:01.000000000 -0400
@@ -136,6 +136,9 @@
 		self.contextdir = "/contexts"
 		self.filecontextdir = self.contextdir+"/files"
 		self.usepwd = usepwd
+		self.default_user = "user_u"
+		self.default_prefix = "user"
+		self.users = self.getUsers()
 
 	def getFileContextDir(self):
 		return self.selinuxdir+self.type+self.filecontextdir
@@ -212,6 +215,10 @@
 		prefs["prefix"] = prefix
 		prefs["home"] = home
 		udict[user] = prefs
+			
+	def setDefaultUser(self, user, prefix):
+		self.default_user = user
+		self.default_prefix = prefix
 		
 	def getUsers(self):
 		udict = {}
@@ -220,7 +227,11 @@
 			for seuser in list:
 				user = []
 				seusername = semanage_seuser_get_sename(seuser)
-				self.adduser(udict, semanage_seuser_get_name(seuser), seusername, self.get_default_prefix(seusername))
+				prefix = self.get_default_prefix(seusername)
+				if semanage_seuser_get_name(seuser) == "__default__":
+					self.setDefaultUser(seusername, prefix)
+
+				self.adduser(udict, semanage_seuser_get_name(seuser), seusername, prefix)
 				
 		else:
 			try:
@@ -270,12 +281,11 @@
 		return ret
 
 	def genHomeDirContext(self):
-		users = self.getUsers()
 		ret = ""
 		# Fill in HOME and prefix for users that are defined
-		for u in users.keys():
-			ret += self.getHomeDirContext (u, users[u]["seuser"], users[u]["home"], users[u]["prefix"])
-			ret += self.getUserContext (u, users[u]["seuser"], users[u]["prefix"])
+		for u in self.users.keys():
+			ret += self.getHomeDirContext (u, self.users[u]["seuser"], self.users[u]["home"], self.users[u]["prefix"])
+			ret += self.getUserContext (u, self.users[u]["seuser"], self.users[u]["prefix"])
 		return ret+"\n"
 
 	def checkExists(self, home):
@@ -322,9 +332,9 @@
 	def genoutput(self):
 		ret = self.heading()
 		for h in self.getHomeDirs():
-			ret += self.getHomeDirContext ("user_u", "user_u" , h+'/[^/]*', "user")
+			ret += self.getHomeDirContext (self.default_user, self.default_user, h+'/[^/]*', self.default_prefix)
 			ret += self.getHomeRootContext(h)
-		ret += self.getUserContext(".*", "user_u", "user") + "\n"
+		ret += self.getUserContext(".*", self.default_user, self.default_prefix) + "\n"
 		ret += self.genHomeDirContext()
 		return ret
 

--------------070409040407080804080509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
