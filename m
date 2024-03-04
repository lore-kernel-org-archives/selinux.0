Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF147A728
	for <selinux@vger.kernel.org>; Mon,  4 Mar 2024 19:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579660; cv=none; b=cvnqHyzuY2jXhXMwasX6cSTBnwC4ctNBIAjHY15xWybU9pAU5SPWmA97vP8V7FVkGzrWw9dq82aHGsSaGsDPqfNualykktIzK0C524XF5PPoBIH61DVcOjOORsevCkkefQ5wyg2CPSm5PFm1cckd+Bdd3w7paNpa26BeZ/JAXv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579660; c=relaxed/simple;
	bh=7rLcmE/0LYhO2ezXpVEwDFHBY9f+D08+HjsAnuYWO6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WuHlVadkYPg0kiRyelshcCPGDkp5sFxVOfUPJvALb+fX2bXXtFnSjYUciClGfm85oQK15ub4SBKqHmgQKVt6LFYQwtll3Q3ooirNQbIuvTGDO7Un3H4E4FEe+xjEOKMr+HuUlykCoJAxtoS0LaIgTpNIC1weJz71Y0M+AGE4LOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMOvgXsS; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMOvgXsS"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7d5bbbe5844so2540143241.0
        for <selinux@vger.kernel.org>; Mon, 04 Mar 2024 11:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709579657; x=1710184457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0ePuO+MFriJG/719NNRfQlO4otKlqW6Y9TGlPXRjLc=;
        b=TMOvgXsSYSxzA4NQf5Fmju+F4/+lODqy6z5eyadqkD8o1JM5CubFJ6XO90Mf7v/GYl
         A6iAYUXns1Ad4XNiVjBxlCdDmA3dro9W7pXDHmoDHUa+k1s2ud1Y418NajwqtfNwelYv
         P9qRizfHsxBAgUn6OHmzfsqOkcuR7mqM8ADtxCIQzc/sqnXxZEWzkn6uDv7UZaFH66Ed
         rDSFwKRjmwubcL59AbWsIcD00LVtuR4eJyDGbu2yJJcjUDt+IJkorX5IlPx/mfgl+nhr
         0cHzBPZmIsqwL/7x8NdOcd0mBRUG4hikdk3oa6VYW+OejyUbTlswDBrJwUA/Y4ocb/DB
         lWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579657; x=1710184457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t0ePuO+MFriJG/719NNRfQlO4otKlqW6Y9TGlPXRjLc=;
        b=vt7gtaO/YCIpI4N7LA5Qvo7/k78HhyWfOGvVw8hJ2+yvT/Wy842lVhNFAb49ElyrXa
         sFQ4KaLJeYTYzsj6aaWF9V0bqB1h76BpvDbJZnISeyqeyht+J8HIWaqzWJf9R13OrrBn
         Qip/djr004+UO6tDoAiMjGlCwp2BOzhy5OGK7QmlMQRNYWMlsWUx47aBoXj1CV1AAM48
         MiH/y0RYEmR8I15ujj5d74TR1pXqWEpAIvP5u80kG6592cOnGP08w7CzgNQT3rewlDq5
         fo2vB6BE0xDsVl2qi0DhGpgnZUkGFGKak2hO5mU570+HpDBUMOsn0slanpxukTvGaOhU
         n6GQ==
X-Gm-Message-State: AOJu0YxMe8pvBvkDcfXmtBWAV9R6Fl6J6+ZKNKdF0qqh41SaYDijVSkO
	899LtJQG4wTdni44S4cfaY+Uc/dNqt0jG3cAV49T9zUzg7+CcH8eKpfVgRF7Egym8kKgX845Gs3
	9voB7UUoqIKJ8592RcgPsKCJnHL+ZCDtZsGM=
X-Google-Smtp-Source: AGHT+IF24vfCALlZ64E+59WhbPmWMdEvneg3x+t422jpAsOjP45GUpQeHDj6xG1AXnZw0BPQQXdSFvwgG5G7TFnoS9o=
X-Received: by 2002:a05:6102:129a:b0:472:667a:b859 with SMTP id
 jc26-20020a056102129a00b00472667ab859mr7011140vsb.25.1709579657260; Mon, 04
 Mar 2024 11:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP+JOzQiC5AVpc7UreV4tafG3PnNCz8O7o4QrD=dLnLdO2oxCw@mail.gmail.com>
 <20240214122706.522873-1-vmojzis@redhat.com>
In-Reply-To: <20240214122706.522873-1-vmojzis@redhat.com>
From: James Carter <jwcart2@gmail.com>
Date: Mon, 4 Mar 2024 14:14:06 -0500
Message-ID: <CAP+JOzTqv7np7EpbcwKY5=kRtCL36=AYEtf0xLL7hr1UwKkspQ@mail.gmail.com>
Subject: Re: [PATCH v2] python/semanage: Allow modifying records on "add"
To: Vit Mojzis <vmojzis@redhat.com>
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 7:27=E2=80=AFAM Vit Mojzis <vmojzis@redhat.com> wro=
te:
>
> When trying to add a record with a key that already exists, modify
> the existing record instead.
>
> Also, fix "semanage -m -e" (add_equal was called instead of
> modify_equal), which meant that existing local equivalency couldn't be
> modified (though a user could remove it and add a modified
> equivalency).
>
> Fixes:
>   https://github.com/SELinuxProject/selinux/issues/412
>   When a port or login definition present in the policy is modified
>   using "semanage port -m", "semanage export" exports the command as
>   "port -a" instead of "port -m". This results in "semanage import"
>   failing (port already defined). The same is true for port, user,
>   login, ibpkey, ibendport, node, interface and fcontext.
>
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Oops, I forgot to ack this version.
Acked-by: James Carter <jwcart2@gmail.com>

It has also been merged.
Thanks,
Jim

> ---
> Added "self.validate" for nodeRecord since it modifies address, mask and
> protocol values.
>
> Fixes:
>  #semanage node -a -M 255.255.255.0 -p ipv4 -t node_t 192.168.0.123
>  Traceback (most recent call last):
>   File "/usr/sbin/semanage", line 976, in <module>
>     do_parser()
>   File "/usr/sbin/semanage", line 951, in do_parser
>     args.func(args)
>   File "/usr/sbin/semanage", line 642, in handleNode
>     OBJECT.add(args.node, args.netmask, args.proto, args.range, args.type=
)
>   File "/usr/lib/python3.9/site-packages/seobject.py", line 1999, in add
>     if self.__exists(addr, mask, proto):
>   File "/usr/lib/python3.9/site-packages/seobject.py", line 2007, in __ex=
ists
>     (rc, k) =3D semanage_node_key_create(self.sh, addr, mask, proto)
>   File "/usr/lib64/python3.9/site-packages/semanage.py", line 1013, in se=
manage_node_key_create
>     return _semanage.semanage_node_key_create(handle, addr, mask, proto)
>  TypeError: in method 'semanage_node_key_create', argument 4 of type 'int=
'
>
>  python/semanage/semanage    |   2 +-
>  python/semanage/seobject.py | 208 +++++++++++++++++++++++++-----------
>  2 files changed, 147 insertions(+), 63 deletions(-)
>
> diff --git a/python/semanage/semanage b/python/semanage/semanage
> index 4fdb490f..b269b9fc 100644
> --- a/python/semanage/semanage
> +++ b/python/semanage/semanage
> @@ -322,7 +322,7 @@ def handleFcontext(args):
>              OBJECT.add(args.file_spec, args.type, args.ftype, args.range=
, args.seuser)
>      if args.action =3D=3D "modify":
>          if args.equal:
> -            OBJECT.add_equal(args.file_spec, args.equal)
> +            OBJECT.modify_equal(args.file_spec, args.equal)
>          else:
>              OBJECT.modify(args.file_spec, args.type, args.ftype, args.ra=
nge, args.seuser)
>      if args.action =3D=3D "delete":
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index cc944ae2..12133b53 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -557,11 +557,6 @@ class loginRecords(semanageRecords):
>          if rc < 0:
>              raise ValueError(_("Could not create a key for %s") % name)
>
> -        (rc, exists) =3D semanage_seuser_exists(self.sh, k)
> -        if rc < 0:
> -            raise ValueError(_("Could not check if login mapping for %s =
is defined") % name)
> -        if exists:
> -            raise ValueError(_("Login mapping for %s is already defined"=
) % name)
>          if name[0] =3D=3D '%':
>              try:
>                  grp.getgrnam(name[1:])
> @@ -600,11 +595,29 @@ class loginRecords(semanageRecords):
>      def add(self, name, sename, serange):
>          try:
>              self.begin()
> -            self.__add(name, sename, serange)
> +            # Add a new mapping, or modify an existing one
> +            if self.__exists(name):
> +                print(_("Login mapping for %s is already defined, modify=
ing instead") % name)
> +                self.__modify(name, sename, serange)
> +            else:
> +                self.__add(name, sename, serange)
>              self.commit()
>          except ValueError as error:
>              raise error
>
> +    # check if login mapping for given user exists
> +    def __exists(self, name):
> +        (rc, k) =3D semanage_seuser_key_create(self.sh, name)
> +        if rc < 0:
> +            raise ValueError(_("Could not create a key for %s") % name)
> +
> +        (rc, exists) =3D semanage_seuser_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if login mapping for %s =
is defined") % name)
> +        semanage_seuser_key_free(k)
> +
> +        return exists
> +
>      def __modify(self, name, sename=3D"", serange=3D""):
>          rec, self.oldsename, self.oldserange =3D selinux.getseuserbyname=
(name)
>          if sename =3D=3D "" and serange =3D=3D "":
> @@ -821,12 +834,6 @@ class seluserRecords(semanageRecords):
>          if rc < 0:
>              raise ValueError(_("Could not create a key for %s") % name)
>
> -        (rc, exists) =3D semanage_user_exists(self.sh, k)
> -        if rc < 0:
> -            raise ValueError(_("Could not check if SELinux user %s is de=
fined") % name)
> -        if exists:
> -            raise ValueError(_("SELinux user %s is already defined") % n=
ame)
> -
>          (rc, u) =3D semanage_user_create(self.sh)
>          if rc < 0:
>              raise ValueError(_("Could not create SELinux user for %s") %=
 name)
> @@ -866,12 +873,28 @@ class seluserRecords(semanageRecords):
>      def add(self, name, roles, selevel, serange, prefix):
>          try:
>              self.begin()
> -            self.__add(name, roles, selevel, serange, prefix)
> +            if self.__exists(name):
> +                print(_("SELinux user %s is already defined, modifying i=
nstead") % name)
> +                self.__modify(name, roles, selevel, serange, prefix)
> +            else:
> +                self.__add(name, roles, selevel, serange, prefix)
>              self.commit()
>          except ValueError as error:
>              self.mylog.commit(0)
>              raise error
>
> +    def __exists(self, name):
> +        (rc, k) =3D semanage_user_key_create(self.sh, name)
> +        if rc < 0:
> +            raise ValueError(_("Could not create a key for %s") % name)
> +
> +        (rc, exists) =3D semanage_user_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if SELinux user %s is de=
fined") % name)
> +        semanage_user_key_free(k)
> +
> +        return exists
> +
>      def __modify(self, name, roles=3D[], selevel=3D"", serange=3D"", pre=
fix=3D""):
>          oldserole =3D ""
>          oldserange =3D ""
> @@ -1103,12 +1126,6 @@ class portRecords(semanageRecords):
>
>          (k, proto_d, low, high) =3D self.__genkey(port, proto)
>
> -        (rc, exists) =3D semanage_port_exists(self.sh, k)
> -        if rc < 0:
> -            raise ValueError(_("Could not check if port {proto}/{port} i=
s defined").format(proto=3Dproto, port=3Dport))
> -        if exists:
> -            raise ValueError(_("Port {proto}/{port} already defined").fo=
rmat(proto=3Dproto, port=3Dport))
> -
>          (rc, p) =3D semanage_port_create(self.sh)
>          if rc < 0:
>              raise ValueError(_("Could not create port for {proto}/{port}=
").format(proto=3Dproto, port=3Dport))
> @@ -1152,9 +1169,23 @@ class portRecords(semanageRecords):
>
>      def add(self, port, proto, serange, type):
>          self.begin()
> -        self.__add(port, proto, serange, type)
> +        if self.__exists(port, proto):
> +            print(_("Port {proto}/{port} already defined, modifying inst=
ead").format(proto=3Dproto, port=3Dport))
> +            self.__modify(port, proto, serange, type)
> +        else:
> +            self.__add(port, proto, serange, type)
>          self.commit()
>
> +    def __exists(self, port, proto):
> +        (k, proto_d, low, high) =3D self.__genkey(port, proto)
> +
> +        (rc, exists) =3D semanage_port_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if port {proto}/{port} i=
s defined").format(proto=3Dproto, port=3Dport))
> +        semanage_port_key_free(k)
> +
> +        return exists
> +
>      def __modify(self, port, proto, serange, setype):
>          if serange =3D=3D "" and setype =3D=3D "":
>              if is_mls_enabled =3D=3D 1:
> @@ -1377,12 +1408,6 @@ class ibpkeyRecords(semanageRecords):
>
>          (k, subnet_prefix, low, high) =3D self.__genkey(pkey, subnet_pre=
fix)
>
> -        (rc, exists) =3D semanage_ibpkey_exists(self.sh, k)
> -        if rc < 0:
> -            raise ValueError(_("Could not check if ibpkey {subnet_prefix=
}/{pkey} is defined").formnat(subnet_prefix=3Dsubnet_prefix, pkey=3Dpkey))
> -        if exists:
> -            raise ValueError(_("ibpkey {subnet_prefix}/{pkey} already de=
fined").format(subnet_prefix=3Dsubnet_prefix, pkey=3Dpkey))
> -
>          (rc, p) =3D semanage_ibpkey_create(self.sh)
>          if rc < 0:
>              raise ValueError(_("Could not create ibpkey for {subnet_pref=
ix}/{pkey}").format(subnet_prefix=3Dsubnet_prefix, pkey=3Dpkey))
> @@ -1424,9 +1449,23 @@ class ibpkeyRecords(semanageRecords):
>
>      def add(self, pkey, subnet_prefix, serange, type):
>          self.begin()
> -        self.__add(pkey, subnet_prefix, serange, type)
> +        if self.__exists(pkey, subnet_prefix):
> +            print(_("ibpkey {subnet_prefix}/{pkey} already defined, modi=
fying instead").format(subnet_prefix=3Dsubnet_prefix, pkey=3Dpkey))
> +            self.__modify(pkey, subnet_prefix, serange, type)
> +        else:
> +            self.__add(pkey, subnet_prefix, serange, type)
>          self.commit()
>
> +    def __exists(self, pkey, subnet_prefix):
> +        (k, subnet_prefix, low, high) =3D self.__genkey(pkey, subnet_pre=
fix)
> +
> +        (rc, exists) =3D semanage_ibpkey_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if ibpkey {subnet_prefix=
}/{pkey} is defined").formnat(subnet_prefix=3Dsubnet_prefix, pkey=3Dpkey))
> +        semanage_ibpkey_key_free(k)
> +
> +        return exists
> +
>      def __modify(self, pkey, subnet_prefix, serange, setype):
>          if serange =3D=3D "" and setype =3D=3D "":
>              if is_mls_enabled =3D=3D 1:
> @@ -1631,12 +1670,6 @@ class ibendportRecords(semanageRecords):
>              raise ValueError(_("Type %s is invalid, must be an ibendport=
 type") % type)
>          (k, ibendport, port) =3D self.__genkey(ibendport, ibdev_name)
>
> -        (rc, exists) =3D semanage_ibendport_exists(self.sh, k)
> -        if rc < 0:
> -            raise ValueError(_("Could not check if ibendport {ibdev_name=
}/{port} is defined").format(ibdev_name=3Dibdev_name, port=3Dport))
> -        if exists:
> -            raise ValueError(_("ibendport {ibdev_name}/{port} already de=
fined").format(ibdev_name=3Dibdev_name, port=3Dport))
> -
>          (rc, p) =3D semanage_ibendport_create(self.sh)
>          if rc < 0:
>              raise ValueError(_("Could not create ibendport for {ibdev_na=
me}/{port}").format(ibdev_name=3Dibdev_name, port=3Dport))
> @@ -1678,9 +1711,23 @@ class ibendportRecords(semanageRecords):
>
>      def add(self, ibendport, ibdev_name, serange, type):
>          self.begin()
> -        self.__add(ibendport, ibdev_name, serange, type)
> +        if self.__exists(ibendport, ibdev_name):
> +            print(_("ibendport {ibdev_name}/{port} already defined, modi=
fying instead").format(ibdev_name=3Dibdev_name, port=3Dport))
> +            self.__modify(ibendport, ibdev_name, serange, type)
> +        else:
> +            self.__add(ibendport, ibdev_name, serange, type)
>          self.commit()
>
> +    def __exists(self, ibendport, ibdev_name):
> +        (k, ibendport, port) =3D self.__genkey(ibendport, ibdev_name)
> +
> +        (rc, exists) =3D semanage_ibendport_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if ibendport {ibdev_name=
}/{port} is defined").format(ibdev_name=3Dibdev_name, port=3Dport))
> +        semanage_ibendport_key_free(k)
> +
> +        return exists
> +
>      def __modify(self, ibendport, ibdev_name, serange, setype):
>          if serange =3D=3D "" and setype =3D=3D "":
>              if is_mls_enabled =3D=3D 1:
> @@ -1902,12 +1949,6 @@ class nodeRecords(semanageRecords):
>          if rc < 0:
>              raise ValueError(_("Could not create key for %s") % addr)
>
> -        (rc, exists) =3D semanage_node_exists(self.sh, k)
> -        if rc < 0:
> -            raise ValueError(_("Could not check if addr %s is defined") =
% addr)
> -        if exists:
> -            raise ValueError(_("Addr %s already defined") % addr)
> -
>          (rc, node) =3D semanage_node_create(self.sh)
>          if rc < 0:
>              raise ValueError(_("Could not create addr for %s") % addr)
> @@ -1955,9 +1996,27 @@ class nodeRecords(semanageRecords):
>
>      def add(self, addr, mask, proto, serange, ctype):
>          self.begin()
> -        self.__add(addr, mask, proto, serange, ctype)
> +        if self.__exists(addr, mask, proto):
> +            print(_("Addr %s already defined, modifying instead") % addr=
)
> +            self.__modify(addr, mask, proto, serange, ctype)
> +        else:
> +            self.__add(addr, mask, proto, serange, ctype)
>          self.commit()
>
> +    def __exists(self, addr, mask, proto):
> +        addr, mask, proto, audit_proto =3D self.validate(addr, mask, pro=
to)
> +
> +        (rc, k) =3D semanage_node_key_create(self.sh, addr, mask, proto)
> +        if rc < 0:
> +            raise ValueError(_("Could not create key for %s") % addr)
> +
> +        (rc, exists) =3D semanage_node_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if addr %s is defined") =
% addr)
> +        semanage_node_key_free(k)
> +
> +        return exists
> +
>      def __modify(self, addr, mask, proto, serange, setype):
>          addr, mask, proto, audit_proto =3D self.validate(addr, mask, pro=
to)
>
> @@ -2111,12 +2170,6 @@ class interfaceRecords(semanageRecords):
>          if rc < 0:
>              raise ValueError(_("Could not create key for %s") % interfac=
e)
>
> -        (rc, exists) =3D semanage_iface_exists(self.sh, k)
> -        if rc < 0:
> -            raise ValueError(_("Could not check if interface %s is defin=
ed") % interface)
> -        if exists:
> -            raise ValueError(_("Interface %s already defined") % interfa=
ce)
> -
>          (rc, iface) =3D semanage_iface_create(self.sh)
>          if rc < 0:
>              raise ValueError(_("Could not create interface for %s") % in=
terface)
> @@ -2163,9 +2216,25 @@ class interfaceRecords(semanageRecords):
>
>      def add(self, interface, serange, ctype):
>          self.begin()
> -        self.__add(interface, serange, ctype)
> +        if self.__exists(interface):
> +            print(_("Interface %s already defined, modifying instead") %=
 interface)
> +            self.__modify(interface, serange, ctype)
> +        else:
> +            self.__add(interface, serange, ctype)
>          self.commit()
>
> +    def __exists(self, interface):
> +        (rc, k) =3D semanage_iface_key_create(self.sh, interface)
> +        if rc < 0:
> +            raise ValueError(_("Could not create key for %s") % interfac=
e)
> +
> +        (rc, exists) =3D semanage_iface_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if interface %s is defin=
ed") % interface)
> +        semanage_iface_key_free(k)
> +
> +        return exists
> +
>      def __modify(self, interface, serange, setype):
>          if serange =3D=3D "" and setype =3D=3D "":
>              raise ValueError(_("Requires setype or serange"))
> @@ -2353,7 +2422,13 @@ class fcontextRecords(semanageRecords):
>              raise ValueError(_("Substitute %s is not valid. Substitute i=
s not allowed to end with '/'") % substitute)
>
>          if target in self.equiv.keys():
> -            raise ValueError(_("Equivalence class for %s already exists"=
) % target)
> +            print(_("Equivalence class for %s already exists, modifying =
instead") % target)
> +            self.equiv[target] =3D substitute
> +            self.equal_ind =3D True
> +            self.mylog.log_change("resrc=3Dfcontext op=3Dmodify-equal %s=
 %s" % (audit.audit_encode_nv_string("sglob", target, 0), audit.audit_encod=
e_nv_string("tglob", substitute, 0)))
> +            self.commit()
> +            return
> +
>          self.validate(target)
>
>          for fdict in (self.equiv, self.equiv_dist):
> @@ -2429,18 +2504,6 @@ class fcontextRecords(semanageRecords):
>          if rc < 0:
>              raise ValueError(_("Could not create key for %s") % target)
>
> -        (rc, exists) =3D semanage_fcontext_exists(self.sh, k)
> -        if rc < 0:
> -            raise ValueError(_("Could not check if file context for %s i=
s defined") % target)
> -
> -        if not exists:
> -            (rc, exists) =3D semanage_fcontext_exists_local(self.sh, k)
> -            if rc < 0:
> -                raise ValueError(_("Could not check if file context for =
%s is defined") % target)
> -
> -        if exists:
> -            raise ValueError(_("File context for %s already defined") % =
target)
> -
>          (rc, fcontext) =3D semanage_fcontext_create(self.sh)
>          if rc < 0:
>              raise ValueError(_("Could not create file context for %s") %=
 target)
> @@ -2479,9 +2542,30 @@ class fcontextRecords(semanageRecords):
>
>      def add(self, target, type, ftype=3D"", serange=3D"", seuser=3D"syst=
em_u"):
>          self.begin()
> -        self.__add(target, type, ftype, serange, seuser)
> +        if self.__exists(target, ftype):
> +            print(_("File context for %s already defined, modifying inst=
ead") % target)
> +            self.__modify(target, type, ftype, serange, seuser)
> +        else:
> +            self.__add(target, type, ftype, serange, seuser)
>          self.commit()
>
> +    def __exists(self, target, ftype):
> +        (rc, k) =3D semanage_fcontext_key_create(self.sh, target, file_t=
ypes[ftype])
> +        if rc < 0:
> +            raise ValueError(_("Could not create key for %s") % target)
> +
> +        (rc, exists) =3D semanage_fcontext_exists(self.sh, k)
> +        if rc < 0:
> +            raise ValueError(_("Could not check if file context for %s i=
s defined") % target)
> +
> +        if not exists:
> +            (rc, exists) =3D semanage_fcontext_exists_local(self.sh, k)
> +            if rc < 0:
> +                raise ValueError(_("Could not check if file context for =
%s is defined") % target)
> +        semanage_fcontext_key_free(k)
> +
> +        return exists
> +
>      def __modify(self, target, setype, ftype, serange, seuser):
>          if serange =3D=3D "" and setype =3D=3D "" and seuser =3D=3D "":
>              raise ValueError(_("Requires setype, serange or seuser"))
> --
> 2.43.0
>
>
