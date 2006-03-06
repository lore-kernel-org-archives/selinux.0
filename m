Subject: Re: Desktop integration
From: Erich Schubert <erich@debian.org>
To: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <440C6DE2.1070705@redhat.com>
References: <43DE6244.5010100@cornell.edu> <43DE6578.9050302@redhat.com>
	 <4403E64B.6010804@cornell.edu> <4404309B.9020001@redhat.com>
	 <44047CFC.3040009@cornell.edu>  <440C6DE2.1070705@redhat.com>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 22:58:34 +0100
Message-Id: <1141682314.32760.58.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> Because the user does not understand.  He creates a cgi script in his 
> home directory or /tmp and then mv's it to /var/www/cgi-bin or 
> /var/www/html.  In his mind the act of moving it to /var/www/html is the 
> act of sharing it.  So

I agree here a lot. We need to think more of the user, too. Security is
worthless when people don't understand it and then just disable it,
because they don't get how to properly use it.

A somewhat related question: Does SELinux have a measure to _prohibit_
certain "file type nestings"?
Right now I think you can basically label any file with any file label;
you'll probably break apps and such, but that is up to you.
But for example, why should files outside of /var be allowed to have any
var_*_t file type? or even bin_t - right now you can label a file
in /var/tmp bin_t, which I really do not want to allow... But it's also
a question at how expensive it is to prohibit.
But I guess the kernel could be equipped with a set of rules that
basically say inode foo maybe labeled bar only if it's parent inodes
have label quux. Gets very complicated however with hard links...

But we could use this at least to prevent the just described problem of
introducing mislabeled files by editing files in a different dir and
then copying them over...

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
   To understand recursion you first need to understand recursion.   //\
  Wer nicht zuweilen zuviel empfindet, der empfindet immer zuwenig.  V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
