From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ewalsh@tycho.nsa.gov
Subject: Re: missing avc message field names
Date: Tue, 30 Jan 2007 23:25:09 +1100
Cc: Steve Grubb <sgrubb@redhat.com>, Karl MacMillan <kmacmill@redhat.com>,
        linux-audit@redhat.com, Steve G <linux_4ever@yahoo.com>,
        selinux@tycho.nsa.gov
References: <20070129185542.32977.qmail@web51502.mail.yahoo.com> <200701291749.21897.sgrubb@redhat.com> <45BE87E0.5090109@tycho.nsa.gov>
In-Reply-To: <45BE87E0.5090109@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701302325.12726.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday 30 January 2007 10:48, Eamon Walsh <ewalsh@tycho.nsa.gov> wrote:
> there might be SELinux-enhanced e-mail clients,
> office applications, file managers in the future

Yes, we need all that.

There are some people interested in SE enhanced MUAs.

One issue is that SE-X is required for full functionality in this regard 
(let's assume for the sake of discussion that almost everyone who matters 
uses a GUI MUA).  Another issue is that the design of MUAs is tending towards 
greater integration with the desktop environment and larger more complex code 
bases.

I'm thinking of starting to attack this by developing a password sequestration 
system for MUAs.  The idea being that the MUA would run a SETGID program and 
request a POP connection, it would be returned a file handle for an 
authenticated connection but have no way of obtaining the password that was 
used.  This will offer significant security benefits in a non-SE environment 
and even better protection with SE Linux.  A compromised MUA would not be 
able to obtain a password list and send it to a hostile party (it would be 
able to proxy access to the POP server and to send copies of all stored 
messages).  Given the incidence of passwords being used for multiple 
functions this would significantly mitigate the risks of MUA based attacks.

The current situation is tending towards having an ever increasing amount of 
the practical system integrity dependant on the integrity of a single user 
account (in which all programs run with the same security context).

Getting upstream support for labelled email is going to be very difficult with 
the current client side security situation.

Now if we could just get web browsers to have their functionality split into 
multiple programs with different security contexts...

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
