Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TJ9nrT018280
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 15:09:49 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TJ9mjQ023719
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 19:09:48 GMT
Subject: Re: Patch to restorecon to add -R switch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <41584DCA.7030006@redhat.com>
References: <41584DCA.7030006@redhat.com>
Content-Type: text/plain
Message-Id: <1096484920.3270.13.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 29 Sep 2004 15:08:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Everything looks fine, but why does all the output just go to the log
file now?  

On Mon, 2004-09-27 at 13:28, Daniel J Walsh wrote:
> This will allow us to
> 
> restorecon -R /dev in the initscripts.
> 
> Also patch adds some fixed for fixfiles.
> 
> Dan
> 
> ______________________________________________________________________

> --- policycoreutils-1.17.5/scripts/fixfiles.rhat	2004-08-30 11:46:47.000000000 -0400
> +++ policycoreutils-1.17.5/scripts/fixfiles	2004-09-24 18:46:15.672622592 -0400
> @@ -36,6 +36,8 @@
>  FILESYSTEMSRO=`mount | grep -v "context=" | egrep -v '\((|.*,)bind(,.*|)\)' | awk '/(ext[23]| xfs | reiserfs ).*\(ro/{print $3}';`
>  FILESYSTEMS="$FILESYSTEMSRW $FILESYSTEMSRO"
>  SELINUXTYPE="targeted"
> +FCFILE=`mktemp /var/tmp/file_contexts.XXXXXXXXXX`
> +trap "rm -f $FCFILE; exit 2" 1 2 3 5 15 
>  
>  if [ -e /etc/selinux/config ]; then
>      . /etc/selinux/config
> @@ -48,14 +50,14 @@
>  echo "logging to $LOGFILE"
>  if [ ! -z "$1" ]; then
>      for i in `echo $1 | sed 's/,/ /g'`; do
> -	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 | tee $LOGFILE
> +	rpm -q -l $i | restorecon ${OUTFILES} -n -v -f - 2>&1 > $LOGFILE
>      done
>  else
>      if [ ! -z "$FILESYSTEMSRO" ]; then
>          echo "Warning: Skipping the following R/O filesystems:"
>          echo "$FILESYSTEMSRO"
>      fi
> -    ${SETFILES} ${OUTFILES} -n -v ${FC} ${FILESYSTEMSRW} 2>&1 | tee $LOGFILE
> +    ${SETFILES} ${OUTFILES} -n -v ${FCFILE} ${FILESYSTEMSRW} 2>&1 > $LOGFILE
>  fi
>  }
>  
> @@ -63,14 +65,14 @@
>  echo "logging to $LOGFILE"
>  if [ ! -z "$1" ]; then
>      for i in `echo $1 | sed 's/,/ /g'`; do
> -	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 | tee $LOGFILE
> +	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 > $LOGFILE
>      done
>  else
>      if [ ! -z "$FILESYSTEMSRO" ]; then
>          echo "Warning: Skipping the following R/O filesystems:"
>          echo "$FILESYSTEMSRO"
>      fi
> -    ${SETFILES} ${OUTFILES} -v ${FC} ${FILESYSTEMS} 2>&1 | tee $LOGFILE
> +    ${SETFILES} ${OUTFILES} -v ${FCFILE} ${FILESYSTEMS} 2>&1 > $LOGFILE
>  fi
>  }
>  
> @@ -80,29 +82,29 @@
>  rm -rf /tmp/.??* /tmp/*
>  if [ ! -z "$1" ]; then
>      for i in `echo $1 | sed 's/,/ /g'`; do
> -	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 | tee $LOGFILE
> +	rpm -q -l $i | restorecon ${OUTFILES} -v -f - 2>&1 > $LOGFILE
>      done
>  else
>      if [ ! -z "$FILESYSTEMSRO" ]; then
>          echo "Warning: Skipping the following R/O filesystems:"
>          echo "$FILESYSTEMSRO"
>      fi
> -    ${SETFILES} ${OUTFILES} -v ${FC} ${FILESYSTEMS} 2>&1 | tee $LOGFILE
> +    ${SETFILES} ${OUTFILES} -v ${FCFILE} ${FILESYSTEMS} 2>&1 > $LOGFILE
>  fi
>  }
>  relabelCheck() {
> -echo -n "
> -Files in the /tmp directory may be labeled incorrectly, this command 
> -can remove all files in /tmp.  If you choose to remove files from /tmp, 
> -a reboot will be required after completion.
> -
> -Do you wish to clean out the /tmp directory [N]? "
> -read answer
> -if [ "$answer" = y -o  "$answer" = Y ]; then 
> -    relabel $1
> -else
> -    restoreLabels $1
> -fi
> +    echo -n "
> +    Files in the /tmp directory may be labeled incorrectly, this command 
> +    can remove all files in /tmp.  If you choose to remove files from /tmp, 
> +    a reboot will be required after completion.
> +    
> +    Do you wish to clean out the /tmp directory [N]? "
> +    read answer
> +    if [ "$answer" = y -o  "$answer" = Y ]; then 
> +	relabel $1
> +    else
> +	restoreLabels $1
> +    fi
>  
>  }
>  

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
