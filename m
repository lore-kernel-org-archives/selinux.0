Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5UIA973002308
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 14:10:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5UI9Iss026624
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 18:09:19 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
	by jazzswing.ncsc.mil  with ESMTP id h5UI9HhY026621
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2003 18:09:18 GMT
Subject: Re: improvements to chcon.c
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
In-Reply-To: <200307010011.22778.russell@coker.com.au>
References: <1056781690.14920.81.camel@columbia>
	 <1056976283.1110.748.camel@moss-huskers.epoch.ncsc.mil>
	 <200307010011.22778.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1056996530.24425.35.camel@columbia>
Mime-Version: 1.0
Date: 30 Jun 2003 14:08:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-06-30 at 10:11, Russell Coker wrote:

> Also I have been thinking that the "-h" option to chcon should become the 
> default.  It seems that most times I run it I want that, and that having it 
> change symlinks rather than their destination is usually the safest option 
> (CF a symlink to /etc/passwd).

Wholeheartedly agreed.

> NB  These same issues apply to chown/chgrp/chmod.  So a patch for this would 
> best be written in a generic manner to solve the issue for all three.  The 
> problems of "chown -R" etc are well known for many years...

Honestly I didn't even realize until now that chown followed symlinks by
default.  I think I'm going to write a little zsh function that wraps
chown/chcon and warns me if I use -R without -h.

Actually, I just did, in case anyone's interested:

function chown () {
    cw-dangerous-command "/bin/chown" $@
}

function chcon () {
    cw-dangerous-command "/usr/bin/chcon" $@
}

function cw-dangerous-command () {
    cmd=$1
    shift
    R_seen=
    h_seen=
    for arg in $@; do
        if test "$arg" = "-R" || test "$arg" = "--recursive"; then
	    R_seen=yes
	fi
        if test "$arg" = "-h" || test "$arg" = "--no-dereference"; then
	    h_seen=yes
	fi
    done
    if test -n "$R_seen" && test -z "$h_seen"; then
	printf "recursive \"%s\" without -h is dangerous; continue? (y/n) " "$cmd"
	read ans
	case "$ans" in
	    y*|Y*) $cmd "$@" ;;
	    *) ;;
	esac
    else
        $cmd "$@"
    fi
}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
