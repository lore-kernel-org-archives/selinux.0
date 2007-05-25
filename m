Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4PEM3fq004462
	for <selinux@tycho.nsa.gov>; Fri, 25 May 2007 10:22:03 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4PEM2oG023572
	for <selinux@tycho.nsa.gov>; Fri, 25 May 2007 14:22:02 GMT
Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: Mark Goldman <mgoldman@tresys.com>
To: James Antill <jantill@redhat.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1180022412.24418.58.camel@code.and.org>
References: <20070521095414.832619201@tresys.com>
	 <20070521095518.515998898@tresys.com>
	 <1179868119.9092.38.camel@localhost.localdomain>
	 <1180015458.3930.173.camel@tresys-winxppro>
	 <1180022412.24418.58.camel@code.and.org>
Content-Type: text/plain
Date: Fri, 25 May 2007 10:22:00 -0400
Message-Id: <1180102920.3930.219.camel@tresys-winxppro>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-24 at 12:00 -0400, James Antill wrote:
>  I feel your pain, doing anything non-trivial with strings in C is
> always a major PITA.
>  As a personal project I've almost got ustr[1] in a 1.0 release, which I
> hope could be used in the SELinux libraries (being able to easily
> integrate it into libraries, is one of it's main points), and would
> solve this problem and others in the SELinux libs. (like the strdup() +
> a bit more data).
I, personally wouldn't object.

> > As for parsing the input to make the substitution easier, I think it
> > would be a lot more work to write or use a full fledged parser.  What
> > we want in this situation is what I wrote in my opinion, although I am
> > open to suggestions.
> 
>  Saying that, there were more than a few problems with semanage_sed()
> even if you discount the genericness of the name:
> 
> 1. You pre-allocate a bad amount of space:
> 
> +       srclen = strlen(src);
> +       maxdest = 2 * srclen;
> +       dest = malloc(maxdest);
> 
> ...consider:
> 
> HOME_DIR        -d      system_u:object_r:user_home_dir_t:s0
> 
> strlen("HOME_DIR") == 8, *2 == 16
> strlen("/home/kmacmillan") == 16
> 
> ...I think, you really want something like:
> 
> +       maxdest = srclen + (replen - vallen) * 2 + 1;
> 
> 
> 2. You pre-reallocate if there isn't enough room to insert a new val,
> even if it's not possible to insert a new val:
> 
> +               min_increment = (dindex + replen + 1) - maxdest;
> +               if (min_increment >= 0) {
> 
> ...consider:
> 
> HOME_DIR/.+     system_u:object_r:user_home_t:s0
> 
> strlen("HOME_DIR/.+") == 11, *2 == 22
> strlen("/home/james") == 11
> 
> ...now when you are at '.' in the above substitution, you'll have
> dindex=11 and replen=11 which will trigger a realloc() even though you
> only have 2 bytes left in src (so HOME_DIR will never match, obviously).
> 
> 
> 3. You should probably be calling strstr() instead of walking the
> string.
> 
> 
> 4. All the sizes are signed int's, and no overflow/underflow checking is
> done. This might be safe due to current usage, but it seems like a bad
> idea to leave it this way in a core security lib.
> 
> 
> [1] http://www.and.org/ustr/

Points all well taken.

-mdg
  

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
