From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Nagendra Tomar <tomer_iisc@yahoo.com>
Subject: Re: Fwd: "star -xattr" in SELinux enabled system
Date: Fri, 8 Jun 2007 10:13:22 +1000
Cc: SELinux@tycho.nsa.gov
References: <2433.82487.qm@web53709.mail.re2.yahoo.com>
In-Reply-To: <2433.82487.qm@web53709.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706081013.23796.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 June 2007 09:02, Nagendra Tomar <tomer_iisc@yahoo.com> wrote:
> Can it be inferred that star (or tar for that matter)  is best avoided if
> we want to make a very  secure/restrictive SELinux policy?

No.  Just that you have to make sure that the combination of the contexts in 
the file and the context of the process that calls star is suitable to permit 
extraction.

> O/w the policy 
> has to be modified for any star tarball that we may want to extract.

If you have to extract an arbitrary tarball (IE restore from backup) then you 
need to do so from a domain that has few restrictions.  If you have a limited 
scope of operation for star then you have to make sure that the source 
archive matches this.

Also in some situations extracting the files to a temporary directory without 
applying contexts and then copying some files and running chcon on them 
(either manually or through a script) will be the correct thing to do.

> I'm 
> running star from the rc scripts (with initrc_t) domain. Everytime I allow
> initrc_t domain some create/write/relabelto/relabelfrom permission, I feel
> that I am allowing more than what I should. Will it be a good idea to
> assign a different domain to the star process and allow that domain all
> these permissions (the problem of future star tarballs failing to extract
> is still there though)

Why do you need to extract many security contexts from a tar file in a rc 
script?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
