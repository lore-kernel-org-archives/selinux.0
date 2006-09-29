Message-ID: <451D2318.4080503@redhat.com>
Date: Fri, 29 Sep 2006 09:43:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: New Patch for Policycoreutils.
References: <451945DB.90209@redhat.com> <1159469080.13831.8.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1159469080.13831.8.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2006-09-26 at 11:23 -0400, Daniel J Walsh wrote:
>   
>> I have updated the patch to remove some of the objectionable changes.
>>     
>
>   
>> diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecon/restorecon.c policycoreutils-1.30.29/restorecon/restorecon.c
>> --- nsapolicycoreutils/restorecon/restorecon.c	2006-09-01 22:32:11.000000000 -0400
>> +++ policycoreutils-1.30.29/restorecon/restorecon.c	2006-09-26 11:06:37.000000000 -0400
>> @@ -47,6 +48,7 @@
>>  static char *progname;
>>  static int errors = 0;
>>  static int recurse = 0;
>> +static int file_exist = 1;
>>  static int force = 0;
>>  #define STAT_BLOCK_SIZE 1
>>  static int pipe_fds[2] = { -1, -1 };
>> @@ -62,6 +64,7 @@
>>  static int add_exclude(const char *directory)
>>  {
>>  	struct stat sb;
>> +	int len=0;
>>     
>
> size_t
>
>   
>>  	if (directory == NULL || directory[0] != '/') {
>>  		fprintf(stderr, "Full path required for exclude: %s.\n",
>>  			directory);
>> @@ -85,12 +88,18 @@
>>  		return 1;
>>  	}
>>  
>> -	excludeArray[excludeCtr].directory = strdup(directory);
>> +	len = strlen(directory);
>> +	if (len > 1 &&  directory[len-1] == '/') {
>> +		excludeArray[excludeCtr].directory = calloc(1,len--);
>>     
>
> calloc() can fail.
>
>   
>> @@ -249,7 +260,8 @@
>>  						freecon(scontext);
>>  						return 1;
>>  					}
>> -				}
>> +				} 
>> +
>>     
>
> Intentional?  Make sure you apply make indent after changes.
>
>   
>> diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/restorecond/Makefile policycoreutils-1.30.29/restorecond/Makefile
>> --- nsapolicycoreutils/restorecond/Makefile	2006-08-28 16:58:19.000000000 -0400
>> +++ policycoreutils-1.30.29/restorecond/Makefile	2006-09-21 17:16:49.000000000 -0400
>> @@ -5,14 +5,14 @@
>>  INITDIR = $(DESTDIR)/etc/rc.d/init.d
>>  SELINUXDIR = $(DESTDIR)/etc/selinux
>>  
>> -CFLAGS ?= -g -Werror -Wall -W
>> -override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
>> +CFLAGS ?= -g -Werror -Wall -W 
>> +override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 -fPIE
>>  LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
>>  
>>  all: restorecond
>>  
>>  restorecond:  restorecond.o utmpwatcher.o stringslist.o
>> -	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>> +	$(CC) -pie $(LDFLAGS) -o $@ $^ $(LDLIBS)
>>     
>
> Shouldn't the -pie go in LDFLAGS, and be overridable for distros that
> don't support pie?
>
>   
Yes
>>  
>>  install: all
>>  	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
>> diff --exclude-from=exclude --exclude='*.po' -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.30.29/scripts/fixfiles
>> --- nsapolicycoreutils/scripts/fixfiles	2006-09-01 22:32:11.000000000 -0400
>> +++ policycoreutils-1.30.29/scripts/fixfiles	2006-09-26 11:16:51.000000000 -0400
>> @@ -117,8 +117,8 @@
>>      exit $?
>>  fi
>>  if [ ! -z "$RPMFILES" ]; then
>> -    for i in `echo $RPMFILES | sed 's/,/ /g'`; do
>> -	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* -f - 2>&1 >> $LOGFILE
>> +    for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
>> +	rpmlist $i | ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -i -f - 2>&1 >> $LOGFILE
>>     
>
> Did you mean to drop -R?
>
>   

Yes

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
