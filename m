Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Reino Wallin <reino@oribium.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Firewall Policy
Date: Tue, 12 Mar 2002 12:11:32 +0100
References: <1015894650.23617.1464.camel@matilda.oribium.com>
In-Reply-To: <1015894650.23617.1464.camel@matilda.oribium.com>
MIME-Version: 1.0
Message-Id: <20020312111616.5EC06D16C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 12 Mar 2002 01:57, Reino Wallin wrote:
> I have a few suggestions to improve the example policy as well.
>
> named_t:
>
> To make the nameserver to work as a slave server, we may consider to
> grant write permissions to named_conf_t:dir and named_conf:file:

For my Debian packages I am going to use a separate type for 
/etc/bind/secondary to allow named to write files to that directory but not 
the other named config files.  No way do I want named writing to my primary 
zone files!

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
