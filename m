Subject: Re: [PATCH -v2] policycoreutils: get setfiles to skip mounts
 without seclabel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thomas Liu <tliu@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, eparis@parisplace.org
In-Reply-To: <1248466334.3465.15.camel@moss-pluto.epoch.ncsc.mil>
References: <1247580944.2266.1.camel@Ares>
	 <1247585401.28321.336.camel@moss-pluto.epoch.ncsc.mil>
	 <1247587468.2164.17.camel@Ares>  <4A5CC564.3090408@redhat.com>
	 <1247842112.2096.0.camel@Ares>
	 <1248466334.3465.15.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 27 Jul 2009 09:21:34 -0400
Message-Id: <1248700894.3465.39.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2009-07-24 at 16:12 -0400, Stephen Smalley wrote:
> On Fri, 2009-07-17 at 10:48 -0400, Thomas Liu wrote:
> > Get setfiles to check paths for seclabel and skip them
> > if it is not supported.
> > 
> > Parse /proc/mounts and add paths that do not have seclabel
> > to the exclude list.  If another path shows up that does
> > have seclabel, remove it from the exclude list, since setfiles
> > will try and when it fails it will skip it.
> > 
> > Also made one of the error messages in add_exclude more
> > descriptive.
> > 
> > Signed-off-by: Thomas Liu <tliu@redhat.com>
> > Signed-off-by: Dan Walsh <dwalsh@redhat.com>
> > ---
> 
> Thanks, merged in policycoreutils 2.0.68.

Applied this patch on top to free the buffer allocated by getline() and
to free any removed entries from the excludeArray.  valgrind
--leak-check=full then shows no leakage.

diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 1c780a4..5e5d957 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -281,6 +281,7 @@ static void remove_exclude(const char *directory)
 	int i = 0;
 	for (i = 0; i < excludeCtr; i++) {
 		if (strcmp(directory, excludeArray[i].directory) == 0) {
+			free(excludeArray[i].directory);
 			if (i != excludeCtr-1)
 				excludeArray[i] = excludeArray[excludeCtr-1];
 			excludeCtr--;
@@ -728,9 +729,11 @@ static void exclude_non_seclabel_mounts()
 	int index = 0, found = 0;
 	char *mount_info[4];
 	char *buf = NULL, *item;
+
 	/* Check to see if the kernel supports seclabel */
 	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
 		return;
+
 	fp = fopen("/proc/mounts", "r");
 	if (!fp)
 		return;
@@ -769,6 +772,8 @@ static void exclude_non_seclabel_mounts()
 		if (!found)
 			add_exclude(mount_info[1]);
 	}
+
+	free(buf);
 }
 
 int main(int argc, char **argv)

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
