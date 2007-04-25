Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3P4omUa030491
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 00:50:48 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3P4olgn006975
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 04:50:47 GMT
Subject: RE: [PATCH 01/33] libsepol: basic serilization support
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588A71AE2@exchange.columbia.tresys.com>
References: <20070423213455.741326000@tresys.com>
	 <20070423213721.090230000@tresys.com>
	 <1177444855.10744.25.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71AE2@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 25 Apr 2007 00:49:45 -0400
Message-Id: <1177476585.3428.91.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-04-24 at 18:29 -0400, Joshua Brindle wrote:
> > From: Karl MacMillan [mailto:kmacmillan@mentalrootkit.com] 
> > 
> > On Mon, 2007-04-23 at 17:34 -0400, jbrindle@tresys.com wrote:
> > > plain text document attachment (sepol.serialize.diff) Serialization 
> > > versioning added to the sepol handle.
> > > 
> > > Serialization utility functions added in serialize.[ch]
> > > ---
> > >  libsepol/include/sepol/handle.h |   17 +
> > >  libsepol/src/handle.c           |   89 +++++++++
> > >  libsepol/src/handle.h           |    5 
> > >  libsepol/src/libsepol.map       |    1 
> > >  libsepol/src/serialize.c        |  389 
> > ++++++++++++++++++++++++++++++++++++++++
> > >  libsepol/src/serialize.h        |   45 ++++
> > >  6 files changed, 546 insertions(+)
> > > 
> > > Index: selinux-pms-support/libsepol/include/sepol/handle.h
> > > ===================================================================
> > > --- selinux-pms-support.orig/libsepol/include/sepol/handle.h
> > > +++ selinux-pms-support/libsepol/include/sepol/handle.h
> > > @@ -1,6 +1,11 @@
> > >  #ifndef _SEPOL_HANDLE_H_
> > >  #define _SEPOL_HANDLE_H_
> > >  
> > > +#include <inttypes.h>
> > > +
> > > +#define SEPOL_SERIAL_VERSION_MAJOR 1
> > > +#define SEPOL_SERIAL_VERSION_MINOR 0
> > > +
> > >  struct sepol_handle;
> > >  typedef struct sepol_handle sepol_handle_t;
> > >  
> > > @@ -10,4 +15,16 @@ sepol_handle_t *sepol_handle_create(void
> > >  /* Destroy a sepol handle. */
> > >  void sepol_handle_destroy(sepol_handle_t *);
> > >  
> > > +/* Serialize the serialization version. */ int 
> > > +sepol_handle_version_serialize(sepol_handle_t * sh, char **data, 
> > > +uint64_t *size);
> > > +
> > > +/* Unserialize the serialization version. */ int 
> > > +sepol_handle_version_unserialize(sepol_handle_t * sh, char **data, 
> > > +uint64_t *size);
> > > +
> > > +/* Get the serialization version. */
> > > +int sepol_handle_get_version(sepol_handle_t *sh, uint32_t * major, 
> > > +uint32_t * minor);
> > > +
> > > +/* Set the serialization version. */
> > > +int sepol_handle_set_version(sepol_handle_t *sh, uint32_t major, 
> > > +uint32_t minor);
> > > +
> > >  #endif
> > 
> > Can you give some idea about how the versioning is supposed 
> > to work? In
> > particular:
> > 
> > * How is it related to the policy version?
> > * Why would it change separately from the policy version?
> > * Is there any advantage to version each component separately 
> > rather that a global version?
> > 
> 
> Most of the stuff we are serializing isn't actually in policy, modules
> are already a serialized version of policy and we don't do anything with
> it, the stuff we are serializing is mostly semanage stuff (file
> contexts, seusers, etc) that have nothing to do with policy.

Well - most of it is closely related.

>  The
> per-component versioning was discussed but thought to be too much
> overhead for the number of objects we are serializing.
> 

I guess the problem with this is it is hard to know exactly what the
version is for. Per-component headers seem better to me.

> > <snip>
> > 
> > > Index: selinux-pms-support/libsepol/src/serialize.c
> > > ===================================================================
> > > --- /dev/null
> > > +++ selinux-pms-support/libsepol/src/serialize.c
> > > @@ -0,0 +1,389 @@
> > > +/* Author: Caleb Case <ccase@tresys.com>
> > > + *
> > > + * Copyright (C) 2004-2007 Tresys Technology, LLC
> > > + *
> > > + *  This library is free software; you can redistribute it and/or
> > > + *  modify it under the terms of the GNU Lesser General Public
> > > + *  License as published by the Free Software Foundation; either
> > > + *  version 2.1 of the License, or (at your option) any 
> > later version.
> > > + *
> > > + *  This library is distributed in the hope that it will be useful,
> > > + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
> > See the GNU
> > > + *  Lesser General Public License for more details.
> > > + *
> > > + *  You should have received a copy of the GNU Lesser 
> > General Public
> > > + *  License along with this library; if not, write to the Free 
> > > +Software
> > > + *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  
> > > +02110-1301  USA  */
> > > +
> > > +#include <stdlib.h>
> > > +#include <string.h>
> > > +#include <limits.h>
> > > +
> > > +#include "handle.h"
> > > +#include "debug.h"
> > > +#include "serialize.h"
> > > +#include "private.h"
> > > +
> > > +/* This file provides general serialize and unserialize 
> > functions. */
> > > +
> > > +/** Serializes various kinds of datum.
> > > + *
> > > + *  Two use cases:
> > > + *  1) Calling serialize with a non-NULL size.
> > > + *     This causes serialize to calculate the expected
> > > + *     size of serializing.  No serialization occurs.
> > > + *     Destructively modifies size.  Data may be NULL.
> > > + *  2) Calling serialize with a NULL size.
> > > + *     This results in data being filled with the
> > > + *     serialized information.  Caller must pre-allocate
> > > + *     space for data.  Destructively modifies data.
> > > + *
> > 
> > Why don't you allocate space for the caller? These two use 
> > cases are, well, odd. If you allocate then the caller can 
> > memcpy and free if they want.
> > 
> 
> It works basically the same way the current policy serialization works,
> pass in the data once to get size, allocate and pass in the buffer to
> which its being serialized. We did this for consistency with the current
> mechanisms.
> 

I'm not certain that I would use the current policy serialization code
as an example for anything - it is very difficult to work with.

> > > + *  This function acts iteratively moving the *data or size values.
> > > + *
> > > + *  Supported datum_types (defined in serialize.h):
> > > + *
> > > + *  SEPOL_SERIAL_INT32_T
> > > + *    Serializes datum to a int32_t as defined in inttypes.h
> > > + *    datum may NOT be NULL.
> > > + *    datum_length is not utilized.
> > > + *  SEPOL_SERIAL_UINT32_T
> > > + *    Serializes datum to a uint32_t as defined in inttypes.h
> > > + *    datum may NOT be NULL.
> > > + *    datum_length is not utilized.
> > > + *  SEPOL_SERIAL_SIZE_T
> > > + *    Serializes datum to a size_t as defined in stddef.h
> > > + *    datum may NOT be NULL.
> > > + *    datum_length is not utilized.
> > 
> > How can you serialize a type that is platform specific? How 
> > would this be handled when communication between a 32 and 64 
> > bit host? I thought we always used fixed width types for all 
> > binary communication anyway.
> > 
> 
> SEPOL_SERIAL_SIZE_T is always 64 bits. We should be checking if it tries
> to serialize into a smaller type, if not that's a bug. 
> 

How can that be? On a 64bit platform I can represent a size that can't
be represented by a 32bit size_t. How can I transfer this data to a
32bit system? I can't put it in a data structure with size_t - it would
have to be unint64_t. So why not just use that?

> > > + *  SEPOL_SERIAL_STRING
> > > + *    Serializes a char*.
> > > + *    datum may be NULL.
> > > + *    datum_length should be the length of the string as 
> > returned by strlen.
> > 
> > Why not call strlen? Especially since the string array version does.
> > 
> 
> IIRC because we use the same entry point for all data types to get to
> these.
> 

But you know it is a string.

> > > + *  SEPOL_SERIAL_STRING_ARRAY
> > > + *    Serializes a char**.
> > > + *    datum may be NULL.
> > > + *    datum_length should be the size of the array.
> > > + *    Each string will be serialized as per 
> > SEPOL_SERIAL_STRING and its size
> > > + *    determined via strlen.
> > > + *
> > > + *  NULL pointers are distinguished (where they are 
> > allowed at all).
> > > + *  In the case of strings this means that a NULL char* has a 
> > > + different
> > > + *  serialization from the empty string "".
> > 
> > Why?
> > 
> 
> Not sure, will check.
> 
> > > + *
> > > + */
> > > +int sepol_serialize(sepol_handle_t * handle,
> > > +		    const void *datum,
> > > +		    size_t datum_length,
> > > +		    unsigned int datum_type, char **data, 
> > uint64_t * size) {
> > 
> > Why a single multiplexed function? Seems _much_ easier to 
> > have a sepol_serialize_string, sepol_serialize_uint32, etc. 
> > This would allow type safety and improve readability, both at 
> > the call site and the definition.
> > 
> 
> We can do that I guess, IMO it doesn't make much of a difference.
> 

I think it makes a big difference.

> > 
> > <snip>
> > 
> > > +		case SEPOL_SERIAL_SIZE_T:
> > > +			if (size == NULL) {
> > > +				temp = calloc(1, sizeof(uint64_t));
> > > +				if (temp == NULL) {
> > > +					status = STATUS_ERR;
> > > +					goto cleanup;
> > > +				}
> > > +
> > > +				*((uint64_t *)temp) = 
> > cpu_to_le64(*((size_t *) datum));
> > > +
> > > +				memcpy(*data, temp, sizeof(uint64_t));
> > > +				*data += sizeof(uint64_t);
> > > +			}
> > > +			else
> > > +				*size += sizeof(uint64_t);
> > > +			break;
> > 
> > Err - I don't think this is allowed. I believe that size_t is 
> > supposed to be word size and there is no reason that word 
> > size is limited to 64 bits.
> > 
> 
> IIRC in ANSI C it is limited to 64 bits. I might be wrong on this but I
> remember us looking it up when this happened.
> 

That sounds unlikely, but more importantly, why? Why not just use
uint64_t?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
