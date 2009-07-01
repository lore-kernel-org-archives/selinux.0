Subject: Re: [PATCH] setfiles converted to fts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1246390368.2856.2.camel@Ares>
References: <1246390368.2856.2.camel@Ares>
Content-Type: text/plain
Date: Wed, 01 Jul 2009 10:31:47 -0400
Message-Id: <1246458707.13464.171.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-06-30 at 15:32 -0400, Thomas Liu wrote:
> This patch converted setfiles/restorecon to using fts instead of nftw.
> It also removed forking, pipes and pre_stat because Dan Walsh and I
> could not figure out what it was for.

Also, please inline your patch as per:
http://lxr.linux.no/linux/Documentation/SubmittingPatches
so that it will be included in the reply for commenting on it.

A couple of comments below.

-static int restore(const char *file)
+static int restore(const char *file, struct stat *sb)
 {
        char *my_file = strdupa(file);
-       struct stat my_sb;
+       struct stat my_sb =  *sb;
        int ret;
        char *context, *newcon;
        int user_only_changed = 0;

If we truly don't need a private stat struct anymore (i.e. fts will pass
us the true stat structure even for symlinks), then just replace all
occurrences of my_sb with sb and remove my_sb altogether.

@@ -549,42 +542,38 @@ static int restore(const char *file)
        if (ret) {
                fprintf(stderr, "%s set context %s->%s failed:'%s'\n",
                        progname, my_file, newcon, strerror(errno));
-               goto out;
+               goto skip;
        }
+      skip:
+       freecon(newcon);
+       return SKIP; 

This looks wrong - it means that you return SKIP in the success path as
well.  I think you wanted skip: to follow the return 0 of the out: path?

       out:
        freecon(newcon);
        return 0;
       err:
        freecon(newcon);
-       return -1;
+       return ERR;
 }
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
