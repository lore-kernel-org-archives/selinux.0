Subject: Re: [RFC PATCH 1/3] reference policy: add "context" security class
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>
In-Reply-To: <4525496E.4090209@trustedcs.com>
References: <4525496E.4090209@trustedcs.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 14:50:31 -0400
Message-Id: <1160074231.26418.30.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-10-05 at 13:05 -0500, Darrel Goeddel wrote:
> Define a new security class "context" and its permission "translate" for
> use by the context translation daemon.  The bit of policy added to the
> setrans_translate_context interface only allows for translation of
> domains and file_contexts.  You can see how this is bad if you try to
> ls -Z /dev.

Yes, as device nodes don't have the file_type attribute, they have
device_node.

> I don't have a trick to allow TE access to every type other
> than grabbing some "big" attributes, then listing every remaining type.
> That obviously does not work in the modular policy model anyway.  Any
> ideas on how we could maybe handle that one? (assuming that anyone else
> does not want TE restriction on the translations :))  How about a
> privilege to use '*' or '~' in typesets...

It shouldn't be to hard to build up, we just need things like:

files_translate_all_contexts()
corenet_translate_all_contexts()
fs_translate_all_contexts()
dev_translate_all_contexts()
domain_translate_all_contexts()

I believe that are the modules that need translate interfaces, and that
should be fairly comprehensive coverage (not complete).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
