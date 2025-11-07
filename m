Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4860D239E9E
	for <selinux@vger.kernel.org>; Fri,  7 Nov 2025 15:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529303; cv=none; b=upNtP0vptL1t8uL2ptr29q2JyH1dXzSAZfXuzvjj0kn31Zm/kgKihMDswlMz16zNM1Zh3BVcZjaB2/4QC//vuzNaep1g6UF1jDKcatKvYNY8hc7k59XD2Q+/O/2uCZAtGoIMyyGG6cgfrEYSRh8hJKKf2r8T5T8Qv6BFKsSWqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529303; c=relaxed/simple;
	bh=YUtb6QVPkvdI9E0rFpxBxFpgWMOqhgUWuR8xxHqf1rg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=mDbAHn+PxfjY3ldJLW+aKxTKZ1hMdTF4HgnViJacIlasNsCDm3XrfQPWwBqco2PDYEGOHB0SYaogyxgYpmXWE2vNsTuU/kK8YpRqc79D47xxErnFQiXJrVfqAyhdwhzv4CYZxNEnGJVPgrWioeWDa4VGZPT50mrW4GC3LhLYEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/kBFRjC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/kBFRjC"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3c2c748bc8so107034566b.2
        for <selinux@vger.kernel.org>; Fri, 07 Nov 2025 07:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762529299; x=1763134099; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMaQmph8i+rzpd5mxqm0tzU398eHQAnYUwO/b1gTkqk=;
        b=L/kBFRjCSw28CQK7j02Y+O2uk7+oc1vTtVuOk2qMeE8PCHQ49PGXteDR99hcWOCdkH
         R+wWl1EMXW+AMUYGy5YYGSzwD9KWkzqCdUdEpyL66l/kjDhNBpUmVVV5f//0sKJZ5hVx
         gPs869qXKHD83t7w5hAopY/3BBumYZSAReN+llP59APHf9ZDy0cA4LptURjb+GMNeUMW
         oziv0zoL6DaadAfU5Y+VnZQ0zzO6AOKJWFa3P1gauCj1QntC/FxH8SWcidcAMzPTcLvu
         GXnj9QgiZoNz9Rgwzu+XdgpQPEWF5GATuw0dLqZtK2LXKPBqaVT8wDpqd+oUAPjMXyCP
         FHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529299; x=1763134099;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMaQmph8i+rzpd5mxqm0tzU398eHQAnYUwO/b1gTkqk=;
        b=mfbqc1Po80rfcIrut6Wey2BYQGtzRhvo9m4pYgJpGu3FskRwjlpDfVUZXSDNEf6f9B
         0kCDIaFZvBp3ypzFmD+3H1fy5d1inJXWZhreNV+4ladmMzEwPplQ+3t3VZ+kab8B411K
         wTgC9dQW6f4YlPcL5sp5baAz/+fXx9FxbyuXqPj60t/nMC4LUg6zAWS6i2ACK1s4NatY
         d0cKw7T0wR/M0SF9m/g5cC6uqK2p7MLhadjJ2Jg+gzCnRWOFZh37pXqCmxLk8Xur4QBS
         iftI9U5TILCQ87KYswoDRbUoS1S8qhmVDRX7+KW2ASSrpwyczsmK5Xom/OyhFpG4mpCQ
         uhNA==
X-Gm-Message-State: AOJu0Yzev02Td18cOIA2UqIVHn/ty3w1yN+fh/YA8M/hgTikP7sFx2AI
	cTWFDhCg05Qck+FuxZPNBSrK/RmVjWHjlZmA04GjPK3zHWlau0yy3e8H
X-Gm-Gg: ASbGncvCLDDF1QEtrmk7QVk47rAQ3aDf9MmYp1ETFKxjkkO3KEU0w0KQxnaNec3yD8C
	2MlyiEcWdAJL2+xAxILffScyqUnwY/lUj1e35/eKgosQh429ueFPPj2bgtDzr4+gakmOyQsWw+G
	K2mI1kIafz3CwiUya4Tj3SZtv1+1uDj1eTDNdzk7jdcUjZxJDLT/T5rgnQt8W2q5PyxaIF14+qM
	5wXPOm00SG1XEaDRzmYu91hnqe0AVBVKg+eORrM8z6B7OUVF9tOh0VqyiCdE2T83c8ojRzOQtlM
	JovWCCy84K+nxncG6efj1jYJaSITaHmhoR2GVWsjPePjLKGPE0VenRXvLQEbr4xGYkF7zhsSZmN
	fteaB/dB8ghZkn1NgU7g45XUpXm5J4vH7XHMBHRE5uN+A5dopIEToKkiRRxTqHo01zJVvNPRQRL
	MEFAbi79luOznuJVg=
X-Google-Smtp-Source: AGHT+IHtmsugaS3Nb6CdAZfn0qq3CI+w6T8AqfRqZ1amgxgU7f/uvkQH7NI9iAn0JEP0kteTtsTrVw==
X-Received: by 2002:a17:907:3e04:b0:b37:4f78:55b2 with SMTP id a640c23a62f3a-b72c0cebcb7mr314246966b.34.1762529299279;
        Fri, 07 Nov 2025 07:28:19 -0800 (PST)
Received: from localhost ([2a0a:ef40:89b:b900:2e0:4cff:feb0:4e4d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm262979766b.65.2025.11.07.07.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 07:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Nov 2025 15:28:18 +0000
Message-Id: <DE2KHPNDIG8K.32EPLLO6H43EX@gmail.com>
To: "Stephen Smalley" <stephen.smalley.work@gmail.com>
Cc: <selinux@vger.kernel.org>, <dominick.grift@defensec.nl>,
 <lautrbach@redhat.com>, <cgzones@googlemail.com>
Subject: Re: DBus Permissions
From: "Rahul Sandhu" <nvraxn@gmail.com>
X-Mailer: aerc 0.20.1
References: <DE1VLLSK1NN9.CCD295WLXVQ6@gmail.com>
 <CAEjxPJ4dX+_jr3oJdzD2veqU7krK+N_nV5eccP5M8Lo+uNYNeQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4dX+_jr3oJdzD2veqU7krK+N_nV5eccP5M8Lo+uNYNeQ@mail.gmail.com>

On Fri Nov 7, 2025 at 1:28 PM GMT, Stephen Smalley wrote:
> On Thu, Nov 6, 2025 at 2:58=E2=80=AFPM Rahul Sandhu <nvraxn@gmail.com> wr=
ote:
>>
>> I've been looking into SELinux support for filtering DBus permissions
>> lately. Right now, we have a few things of note from the dbus class:
>>
>> (class dbus (acquire_svc send_msg))
>>
>> 1. acquire_svc. This is useful for:
>>    Allowing contexts to own names on the bus. We have numerous names
>>    that exist on the bus that are effectively trusted: applications
>>    need to be able to trust that the owner of a name is the intended
>>    target. An example of this would be org.freedesktop.PolicyKit1 and
>>    polkit: applications check if unprivileged subjects are allowed to
>>    perform privileged operations using this DBus API. We can make use of
>>    acquire_svc to ensure that only e.g. polkit.subj may own that name.
>>
>> 2. send_msg. This is useful for ensuring that subjects may only speak
>>    to their intended targets.
>>
>> However, this has some serious limitations. For one, many names on the
>> bus provide *both* unprivileged and privileged interfaces. An example
>> of this is org.freedesktop.systemd1, the systemd api. It has various
>> actions that aren't all that privileged (for example GetUnit) as well
>> as actions that are highly privileged (such as StartUnit). A bug has
>> been filed[1] such that any service capable of speaking to systemd over
>> dbus can effectively escape its sandboxing (systemd's sandboxing, not
>> selinux confinement)! It can simply start a transient unit using dbus
>> without the same restrictions applied to the unit.
>>
>> In the case of systemd however, the situation is actually *much* better
>> than other cases: systemd is actually SELinux aware and is an object
>> manager, which means we at least have some control over what happens.
>> However, dbus is a pretty fundermental IPC primative for desktop Linux.
>> Plenty of things that aren't object managers nor SELinux aware provide
>> privileged and unprivileged interfaces on the same bus name. One of the
>> main advantages of brokering is the ability to perform various checks
>> without the server needing to implement them.
>>
>> Hence, I propose extending what we can do with DBus to allow us to be
>> much more granular with it. Other LSMs and IPC systems already have
>> access control similar to this:
>>
>> 1. Android's binder supports service names being labelled[2]. This is
>>    slightly different to the case of DBus here with binder being part
>>    of the kernel, however the core concept could still apply as we may
>>    simply provide dropins to extend the functionality of dbus config
>>    to label names, and extend the dbus class. This would provide back-
>>    wards compatability. It's also somewhat limited however because of
>>    the DBus IPC design.
>>
>> 2. AppArmor has a much more rich access control setup for DBus. It does
>>    not require installing DBus policy files, and supports performing
>>    filtering based on the bus type, the path on the bus, the interface,
>>    and the member. It also supports representing this all in policy[3].
>>    This is in my opinion a much cleaner approach than requiring us to
>>    have loads of labels for each possible member and interface. However,
>>    I don't really have any idea as to how we this could represented in
>>    policy. Maybe something using xperms? But I'm a bit lost as to how
>>    an xperm set could be mapped to it.
>
> In the olden days before SELinux, when we were working with the CMU
> Mach microkernel and its IPC system [1],
> we auto-generated access vector definitions (permission names) from
> the Mach Interface Generation (MIG) files,
> and each access vector had a general portion with common permissions
> and then a service-specific portion with the
> generated permissions. As long as you have no more than 32 interfaces
> per interface, you can fit that in an access vector
> without xperms; else you could use xperms for that purpose. WRT
> xperms, it's just a matter of mapping each interface to
> an integer index which likely already happens and then using that to
> generate a mapping for policy writers to use.

That might very well be a good feasible option actually. I also took a
look at what actually needs labelling and came up with another idea too
to label each member (effectively the IPC endpoints) with a context.

This actually would not require an xperm, and in theory could be a dbus
only change! I think it would be nice however to support emitting the
dbus_contexts file from policy (similar to fc files and filecons in cil
and kernel policy language), although I understand this is a pretty big
change (although actually quite scoped) so very open to feedback on it.

Here is a snippet of pseudopolicy I came up with last night:

(in polkit

    (block dbus

      (dbuspeer peer "org.freedesktop.PolicyKit1")

      (type CheckAuthorization)
      (roletype .sys.role CheckAuthorization)

      (context CheckAuthorization_context (.sys.id .sys.role CheckAuthoriza=
tion .sys.lowlow))

      (dbuscon system "/org/freedesktop/PolicyKit1/Authority"
       "org.freedesktop.PolicyKit1.Authority" "CheckAuthorization" peer
       CheckAuthorization_context)))

(type mysubj)
(roletype .sys.role mysubj)

(allow mysubj .polkit.dbus.CheckAuthorization (dbus (send)))

We then wire up dbus to support labelling members as the IPC endpoints
with a context, and have the dbuscon statements emit a dbus_contexts
file.

dbuscon isn't really a requirement, although I think it would be a nice
to have. Regardless, I'll wait a bit before submitting any patches to
the dbus upstream at FDO incase anyone from the community has design
concerns or feature requests they'd like implemented, considering this
is a pretty major change to dbus, community approval is desired in the
design.

>
> [1] https://www-old.cs.utah.edu/flux/fluke/html/dtos/HTML/dtos.html
>
>> [1] https://github.com/systemd/systemd/issues/8846
>> [2] https://source.android.com/docs/core/architecture/hidl/binder-ipc#na=
mes
>> [3] https://man.archlinux.org/man/apparmor.d.5.en#DBus_rules
>>
>> Thoughts/suggestions?
>> Rahul

