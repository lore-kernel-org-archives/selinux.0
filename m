Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: apache configuration etc
Date: Thu, 12 Sep 2002 21:35:40 +0200
MIME-Version: 1.0
Message-Id: <200209122135.40681.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I think that the Apache policy should be macroised.

Apache is almost impossible to configure securely if you do anything 
non-trivial.

For example a sensible configuration might have one instance of Apache for 
public files that doesn't support https, and another for more important files 
that only does https.

The instance for public files could then be denied access to the secret files 
so that a trivial misconfiguration would not publish them in the clear.

Also the secure instance could be denied access to user home directories (and 
thus all the attacks that users might try to launch through .htaccess files, 
symlinks, bad data, etc).

On some of the ISP servers I run there are three distinct types of Apache 
setup.
Secure servers running SSL for password protected content (allowing customers 
to view payment details or change passwords - and for CGI database access for 
customers who pay extra).

Bulk virtual hosting for customers who have their own domains.

www.isp.com/~user for customers who pay the minimal amount.

Having three instances of Apache with different SE perms would help for that.

I'll get around to doing this myself eventually, I'm just posting this for 
ideas for anyone else who wants to do it first.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
