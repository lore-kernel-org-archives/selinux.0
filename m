Message-ID: <421C9750.4080402@redhat.com>
Date: Wed, 23 Feb 2005 09:46:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: policycoreutils fixes
Content-Type: multipart/mixed;
 boundary="------------070200020002000103090603"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070200020002000103090603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix genhomedircon:
     always add "\n"
    Strip extra spaces off of config files (SELINUXPOLICYTYPE)

Fix fixfiles:
    Use find recursion instead of restorecon to walk directory tree so 
that it will
not go into file systems that do not support extended attributes.

Dan

--------------070200020002000103090603
Content-Type: text/plain;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.21.19/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-02-08 13:27:03.000000000 -0500
+++ policycoreutils-1.21.19/scripts/fixfiles	2005-02-23 09:31:45.000000000 -0500
@@ -78,8 +78,8 @@
                   esac; \
                fi; \
             done | \
-	while read pattern ; do find $pattern -maxdepth 0 -print; done 2> /dev/null | \
-	 ${RESTORECON} -R $2 -v -e /root -e /home -e /tmp -e /var/tmp -e /dev -f - 
+	while read pattern ; do find $pattern -fstype ext2 -fstype ext3 -fstype reiserfs -fstype xfs -print; done 2> /dev/null | \
+	 ${RESTORECON} $2 -v -e /root -e /home -e /tmp -e /var/tmp -e /dev -f - 
 	rm -f ${TEMPFILE}
 fi
 }
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/genhomedircon policycoreutils-1.21.19/scripts/genhomedircon
--- nsapolicycoreutils/scripts/genhomedircon	2005-02-17 14:28:23.000000000 -0500
+++ policycoreutils-1.21.19/scripts/genhomedircon	2005-02-23 09:33:26.000000000 -0500
@@ -154,13 +154,13 @@
 def getDefaultHomeDir():
     rc=commands.getstatusoutput("grep ^HOME= /etc/default/useradd | tail -1")
     if rc[0]==0:
-        return rc[1].split("=")[-1]
+        return rc[1].split("=")[-1].strip()
     return "/home"
 
 def getSELinuxType(directory):
     rc=commands.getstatusoutput("grep ^SELINUXTYPE= %s/config | tail -1" % directory)
     if rc[0]==0:
-        return rc[1].split("=")[-1]
+        return rc[1].split("=")[-1].strip()
     return "targeted"
 
 def usage(error = ""):
@@ -203,7 +203,7 @@
     def getHomeRootContext(self, homedir):
 	    rc=commands.getstatusoutput("grep HOME_ROOT  %s | sed -e \"s|^HOME_ROOT|%s|\"" % ( self.getHomeDirTemplate(), homedir))
 	    if rc[0] == 0:
-		    return rc[1]
+		    return rc[1]+"\n"
 	    else:
 		    errorExit(string.join("sed error ", rc[1]))
 
@@ -254,7 +254,7 @@
 	# Fill in HOME and ROLE for users that are defined
 	for u in users.keys():
 		ret += self.getHomeDirContext (u, users[u]["home"], users[u]["role"])
-	return ret
+	return ret+"\n"
 
     def checkExists(self, home):
         return commands.getstatusoutput("grep -E '^%s[^[:alnum:]_-]' %s" % (home, self.getFileContextFile()))[0]
@@ -285,7 +285,6 @@
 	ret= self.heading()
         for h in self.getHomeDirs():
             ret += self.getHomeDirContext ("user_u" , h+'/[^/]*', "user")
-            ret += "\n"
             ret += self.getHomeRootContext(h)
         ret += self.genHomeDirContext()
         return ret

--------------070200020002000103090603--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
