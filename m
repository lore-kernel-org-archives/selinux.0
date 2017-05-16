Message-ID: <1494960311.21557.6.camel@tycho.nsa.gov>
Subject: Re: [PATCH v1 2/9] libsepol: Add ibpkey ocontext handling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Dan Jurgens <danielj@mellanox.com>, selinux@tycho.nsa.gov
Date: Tue, 16 May 2017 14:45:11 -0400
In-Reply-To: <1494960225.21557.5.camel@tycho.nsa.gov>
References: <1494880961-73481-1-git-send-email-danielj@mellanox.com>
 <1494880961-73481-3-git-send-email-danielj@mellanox.com>
 <1494960225.21557.5.camel@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-05-16 at 14:43 -0400, Stephen Smalley wrote:
> On Mon, 2017-05-15 at 23:42 +0300, Dan Jurgens wrote:
> > From: Daniel Jurgens <danielj@mellanox.com>
> > 
> > Add support for reading, writing, and copying Infinabinda Pkey 
> 
> Infiniband
> 
> > ocontext
> > data. Also add support for querying a Pkey sid to checkpolicy.
> > 
> > Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> > 
> > ---
> > v1:
> > Stephen Smalley:
> > - Removed domain and type params from sepol_ibpkey_sid.
> > - Removed splen param from sepol_ibpkey_sid, it never varied.
> > - Removed extra XPERMS_IOCTL version from policydb_compat_info.
> > - Confirm that low order bytes of IPv6 addr for subnet prefix is
> > 0's.
> > 
> > James Carter:
> > - Added ibpkey handling to kernel_to_cil.c and kernel_to_conf.c
> > 
> > Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> > ---
> >  checkpolicy/checkpolicy.c                  | 25 +++++++++++++
> >  libsepol/include/sepol/policydb/services.h |  8 ++++
> >  libsepol/src/expand.c                      |  9 +++++
> >  libsepol/src/kernel_to_cil.c               | 58
> > +++++++++++++++++++++++++++++
> >  libsepol/src/kernel_to_conf.c              | 59
> > ++++++++++++++++++++++++++++++
> >  libsepol/src/libsepol.map.in               |  1 +
> >  libsepol/src/module_to_cil.c               | 38
> > +++++++++++++++++++
> >  libsepol/src/policydb.c                    | 37
> > +++++++++++++++++++
> >  libsepol/src/services.c                    | 51
> > ++++++++++++++++++++++++++
> >  libsepol/src/write.c                       | 16 ++++++++
> >  10 files changed, 302 insertions(+)
> > 
> > diff --git a/libsepol/include/sepol/policydb/services.h
> > b/libsepol/include/sepol/policydb/services.h
> > index 9162149..459254e 100644
> > --- a/libsepol/include/sepol/policydb/services.h
> > +++ b/libsepol/include/sepol/policydb/services.h
> > @@ -188,6 +188,14 @@ extern int sepol_port_sid(uint16_t domain,
> >  			  uint16_t port, sepol_security_id_t *
> > out_sid);
> >  
> >  /*
> > + * Return the SID of the ibpkey specified by
> > + * `subnet prefix', and `pkey'.
> > + */
> > +extern int sepol_ibpkey_sid(void *subnet_prefix_p,
> 
> Why void *?  Can't this just be struct in6_addr *subnet_prefix or
> uint32_t subnet_prefix[]?  The only reason we use void *addr in
> sepol_node_sid() is because that argument can actually vary depending
> on the domain.  Likely can be const too.
> 
> > +			    uint16_t pkey,
> > +			    sepol_security_id_t *out_sid);
> > +
> > +/*
> >   * Return the SIDs to use for a network interface
> >   * with the name `name'.  The `if_sid' SID is returned for 
> >   * the interface and the `msg_sid' SID is returned as
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 54bf781..c45ecbe 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -4,6 +4,7 @@
> >   *
> >   * Copyright (C) 2004-2005 Tresys Technology, LLC
> >   * Copyright (C) 2007 Red Hat, Inc.
> > + * Copyright (C) 2017 Mellanox Technologies, Inc.
> >   *
> >   *  This library is free software; you can redistribute it and/or
> >   *  modify it under the terms of the GNU Lesser General Public
> > @@ -2217,6 +2218,14 @@ static int
> > ocontext_copy_selinux(expand_state_t *state)
> >  					return -1;
> >  				}
> >  				break;
> > +			case OCON_IBPKEY:
> > +				n->u.ibpkey.subnet_prefix[0] = c-
> > > u.ibpkey.subnet_prefix[0];
> > 
> > +				n->u.ibpkey.subnet_prefix[1] = c-
> > > u.ibpkey.subnet_prefix[1];
> > 
> > +				n->u.ibpkey.subnet_prefix[2] = c-
> > > u.ibpkey.subnet_prefix[2];
> > 
> > +				n->u.ibpkey.subnet_prefix[3] = c-
> > > u.ibpkey.subnet_prefix[3];
> 
> [2] and [3] should always be zero.
> 
> > +				n->u.ibpkey.low_pkey = c-
> > > u.ibpkey.low_pkey;
> > 
> > +				n->u.ibpkey.high_pkey = c-
> > > u.ibpkey.high_pkey;
> > 
> > +			break;
> >  			case OCON_PORT:
> >  				n->u.port.protocol = c-
> > > u.port.protocol;
> > 
> >  				n->u.port.low_port = c-
> > > u.port.low_port;
> > diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> > index 7093b29..d6e8e6f 100644
> > --- a/libsepol/src/policydb.c
> > +++ b/libsepol/src/policydb.c
> > 
> > @@ -2782,6 +2804,21 @@ static int ocontext_read_selinux(struct
> > policydb_compat_info *info,
> >  				    (&c->context[1], p, fp))
> >  					return -1;
> >  				break;
> > +			case OCON_IBPKEY:
> > +				rc = next_entry(buf, fp,
> > sizeof(uint32_t) * 6);
> > +				if (rc < 0 || buf[2] || buf[3])
> > +					return -1;
> 
> Kernel code also rejects buf[4] or buf[5] > 0xffff.
> 
> > +
> > +				c->u.ibpkey.subnet_prefix[0] =
> > buf[0];
> > +				c->u.ibpkey.subnet_prefix[1] =
> > buf[1];
> > +
> > +				c->u.ibpkey.low_pkey =
> > le32_to_cpu(buf[4]);
> > +				c->u.ibpkey.high_pkey =
> > le32_to_cpu(buf[5]);
> > +
> > +				if (context_read_and_validate
> > +				    (&c->context[0], p, fp))
> > +					return -1;
> > +				break;
> >  			case OCON_PORT:
> >  				rc = next_entry(buf, fp,
> > sizeof(uint32_t) * 3);
> >  				if (rc < 0)
> > diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> > index e75b9ab..fa1b7d1 100644
> > --- a/libsepol/src/write.c
> > +++ b/libsepol/src/write.c
> > @@ -16,6 +16,7 @@
> >   *
> >   * Copyright (C) 2004-2005 Trusted Computer Solutions, Inc.
> >   * Copyright (C) 2003-2005 Tresys Technology, LLC
> > + * Copyright (C) 2017 Mellanox Technologies Inc.
> >   *
> >   *  This library is free software; you can redistribute it and/or
> >   *  modify it under the terms of the GNU Lesser General Public
> > @@ -1410,6 +1411,21 @@ static int ocontext_write_selinux(struct
> > policydb_compat_info *info,
> >  				if (context_write(p, &c-
> > >context[1], 
> > fp))
> >  					return POLICYDB_ERROR;
> >  				break;
> > +			case OCON_IBPKEY:
> > +				 /* The subnet prefix is in
> > network
> > order */
> > +				for (j = 0; j < 4; j++)
> > +					buf[j] = c-
> > > u.ibpkey.subnet_prefix[j];
> 
> Kernel write code always writes [2] and [3] as 0.

This btw again raises the question of whether it worth storing them in
the binary policy at all.

> 
> > +
> > +				buf[4] = cpu_to_le32(c-
> > > u.ibpkey.low_pkey);
> > 
> > +				buf[5] = cpu_to_le32(c-
> > > u.ibpkey.high_pkey);
> > 
> > +
> > +				items = put_entry(buf,
> > sizeof(uint32_t), 6, fp);
> > +				if (items != 6)
> > +					return POLICYDB_ERROR;
> > +
> > +				if (context_write(p, &c-
> > >context[0], 
> > fp))
> > +					return POLICYDB_ERROR;
> > +				break;
> >  			case OCON_PORT:
> >  				buf[0] = c->u.port.protocol;
> >  				buf[1] = c->u.port.low_port;
