From: "Richard Herbert Wanner" <richard.wanner@cgi.com>
To: "SELinux List" <SELinux@tycho.nsa.gov>
Subject: GDM and PAM problems?
Date: Mon, 3 Nov 2003 19:54:38 -0500
Message-ID: <GMECJOINLDFDGEEPGINLMEMBCKAA.richard.wanner@cgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1067890582.1269.32.camel@colossus.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I have built a 2.6 Kernel on top of Fedora (test 3) using Dan Walsh's selUpgrade script.  It worked like a charm.

There does seem to be a problem with GDM and PAM with those RPMs.  If I install the GDM and PAM RPMs, I get an error of "Cannot get default context for jadmin" right after login with the jadmin user (or any other user).

Without the GDM and PAM RPMs it works great!

Anybody know what the solution might be?

Thanks
Rick



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
