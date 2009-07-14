Subject: Re: [PATCH] policycoreutils: get setfiles to skip mounts without
 seclabel
From: Thomas Liu <tliu@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org,
        dwalsh@redhat.com
In-Reply-To: <1247585401.28321.336.camel@moss-pluto.epoch.ncsc.mil>
References: <1247580944.2266.1.camel@Ares>
	 <1247585401.28321.336.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 14 Jul 2009 12:04:28 -0400
Message-Id: <1247587468.2164.17.camel@Ares>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-07-14 at 11:30 -0400, Stephen Smalley wrote:
> On Tue, 2009-07-14 at 10:15 -0400, Thomas Liu wrote:
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
> > 
> >  policycoreutils/setfiles/setfiles.c |   80 ++++++++++++++++++++++++++++++++++-
> >  1 files changed, 77 insertions(+), 3 deletions(-)
> > 
> > 
> > diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
> > index 1356fb9..9f27a1d 100644
> > --- a/policycoreutils/setfiles/setfiles.c
> > +++ b/policycoreutils/setfiles/setfiles.c
> > @@ -11,6 +11,7 @@
> >  #include <ctype.h>
> >  #include <regex.h>
> >  #include <sys/vfs.h>
> > +#include <sys/utsname.h>
> >  #define __USE_XOPEN_EXTENDED 1	/* nftw */
> >  #define SKIP -2
> >  #define ERR -1
> > @@ -39,7 +40,7 @@ static int force = 0;
> >  static int progress = 0;
> >  static unsigned long long count = 0;
> >  
> > -#define MAX_EXCLUDES 100
> > +#define MAX_EXCLUDES 1000
> >  static int excludeCtr = 0;
> >  struct edir {
> >  	char *directory;
> > @@ -243,8 +244,8 @@ static int add_exclude(const char *directory)
> >  		return 1;
> >  	}
> >  	if (lstat(directory, &sb)) {
> > -		fprintf(stderr, "Directory \"%s\" not found, ignoring.\n",
> > -			directory);
> > +		fprintf(stderr, "Can't stat directory \"%s\", %s.\n",
> > +			directory, strerror(errno));
> 
> Might want to keep the "ignoring" part as otherwise this appears to be a
> fatal error.
> 
> >  		return 0;
> >  	}
> >  	if ((sb.st_mode & S_IFDIR) == 0) {
> > @@ -275,6 +276,20 @@ static int add_exclude(const char *directory)
> >  	return 0;
> >  }
> >  
> > +static void remove_exclude(const char *directory)
> > +{
> > +	int i = 0;
> > +	for (i = 0; i < excludeCtr; i++) {
> > +		if (strcmp(directory, excludeArray[i].directory) == 0) {
> > +			if (i != excludeCtr-1)
> > +				excludeArray[i] = excludeArray[excludeCtr-1];
> > +			excludeCtr--;
> > +			return;
> > +		}
It doesn't only work if removing the last entry.  If the current entry
matches the directory we passed in, it swaps it with the last one and
then decrements excludeCtr, "removing" the current entry.
> The function name and interface doesn't clearly indicate that this
> function only works if removing the last entry (and if so, why are we
> scanning the entire array)?  But see below as well.
> 
> > +	}
> > +	return;
> > +}
> > +
> >  static int exclude(const char *file)
> >  {
> >  	int i = 0;
> > @@ -699,6 +714,62 @@ static void maybe_audit_mass_relabel(void)
> >  #endif
> >  }
> >  
> > +/*
> > +   Search /proc mounts for all file systems that do not support extended
> > +   attributes and add them to the exclude directory table.  File systems
> > +   support seclabel are labeled seclabel
> > +*/
> > +static void exclude_non_seclabel_mounts()
> > +{
> > +	struct utsname uts;
> > +	FILE *fp = fopen("/proc/mounts", "r");
> > +	size_t len;
> > +	ssize_t num;
> > +	int index = 0, found = 0;
> > +	char *mount_info[4];
> > +	char *buf = NULL, *item;
> > +	/* Check to see if the kernel supports seclabel */
> > +	if (uname(&uts) == 0 && strverscmp(uts.release, "2.6.30") < 0)
> > +		return;
> 
> Move the fopen down here, or fclose(fp) before returning above.
> 
> > +	if (!fp)
> > +		return;
> > +
> > +	while ((num = getline(&buf, &len, fp)) != -1) {
> > +		found = 0;
> > +		index = 0;
> > +		item = strtok(buf, " ");
> > +		while (item != NULL) {
> > +			mount_info[index] = item;
> > +			if (index == 3)
> > +				break;
> > +			index++;
> > +			item = strtok(NULL, " ");
> > +		}
> > +		if (index < 3) {
> > +			fprintf(stderr,
> > +				"/proc/mounts record \"%s\" has incorrect format.\n",
> > +				buf);
> > +			continue;
> > +		}
> > +
> > +		/* remove pre-existing entry */
> > +		remove_exclude(mount_info[1]);
Our impression is that it is needed, because of bind mounts or if two
things are just mounted in the same place.

Although it seems that maybe the logic should be always add and remove
if found instead of always removing and adding if not found.

Thoughts?

> Do we really need this?  Are there multiple entries on the same mount
> point directory with different option lists?  Is this to handle special
> cases like rootfs (which should likely just get ignored)?
> 
> > +
> > +		item = strtok(mount_info[3], ",");
> > +		while (item != NULL) {
> > +			if (strcmp(item, "seclabel") == 0) {
> > +				found = 1;
> > +				break;
> > +			}
> > +			item = strtok(NULL, ",");
> > +		}
> > +
> > +		/* exclude mount points with out seclabel flag */
> > +		if (!found)
> > +			add_exclude(mount_info[1]);
> > +	}
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >  	struct stat sb;
> > @@ -766,6 +837,9 @@ int main(int argc, char **argv)
> >  			exit(0);
> >  	}
> >  
> > +	/* This must happen before getops */
> > +	exclude_non_seclabel_mounts();
That's true.  I guess I could either have add_exclude check to see if it's
already in the list or just always remove first.

> What happens if a directory gets excluded by both this logic and via
> explicit option?  We don't want multiple entries in the array for that.
> 
> > +
> >  	/* Process any options. */
> >  	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW0")) > 0) {
> >  		switch (opt) {
> > 
> > 
> > 
> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> > the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
