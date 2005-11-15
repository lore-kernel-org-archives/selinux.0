Message-ID: <20051115155448.17522.qmail@web51512.mail.yahoo.com>
Date: Tue, 15 Nov 2005 07:54:48 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: sewatch (small script tracking audit.log)
To: shintarou_fujiwara <shin216@xf7.so-net.ne.jp>,
   SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1132067932.2179.34.camel@papa.intrajp-yokosuka.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


>I've written down another script
>which tracks audit.log.

>From the script:
less /var/log/audit/audit.log|grep denied > $err_newfile

This is likely to be slow if you really do a lot of auditing. It is faster to do
this:

ausearch -m AVC | grep denied > $err_newfile

But, following this farther...ausearch has a -ts and -te parameter to set a start
time and an end time. ausearch also returns 0 for a hit and 1 for no hits on the
search, so you could theoretically do this:

export LC_ALL="C"
dn=`date "+%x"`
tn=`date "+%X"
ld=`cat /etc/lasttime | awk '{ print %1 }'`
lt=`cat /etc/lasttime | awk '{ print %2 }'`

ausearch -ts $ld $lt -te $dn %tn -m AVC >/dev/null
if [ $? -eq 0 ] then
# re-run and send email
fi
echo "$dn %tn" > /etc/lasttime

You can experiment with this approach.

It should also be noted that the audit system is in the process of new
development to avoid this kind of issue. In rawhide, the latest audit daemon has
a program /sbin/audisp, which will be a realtime audit event dispatcher. The
audit deamon has a new config parameter "dispatcher" that can be pointed to any
program, even a script. It sends the events via a pipe to that application. At
the moment, a simple program is distributed that only writes to syslog just to
demonstrate the concept.

If anyone writes a dispatcher that you want to share, please send it to me or the
linux-audit mail list. We are currently working on a full featured dispatcher
that should be out in a week or two. But that doesn't preclude people from doing
their own thing. Choices are good. :)

-Steve


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
